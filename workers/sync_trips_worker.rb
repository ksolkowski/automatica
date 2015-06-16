class SyncTripsWorker
  METADATA = '_metadata'
  RESULTS = 'results'
  TRIPS = 'trips'
  include Sidekiq::Worker
 
  def perform(car_id)
    car = Car.find_by_id(car_id)
    pagination_params = {
      page: 1,
      limit: 100,
      vehicle: car.automatic_id
    }

    trips_already_saved = car.trips.map{|x|x.automatic_id}

    # only want the ones not synced
    if car.trips.present?
      last_trip = car.trips.last
      pagination_params[:started_at__gte] = last_trip.started_at.to_i
    end

    trips_route = Automatic::Client.routes.route_for(TRIPS)
    trips_url   = trips_route.url_for(pagination_params)

    is_next = true
    while is_next
      trips_request = Automatic::Client.get(trips_url)
      trips_request.on(:success) do |resp|
        metadata  = Automatic::Models::Response::Metadata.new(resp.body.fetch(METADATA, {}))
        trips_url = metadata.next
        resp.body.fetch(RESULTS, []).map{|x| Automatic::Models::Trip.new(x) }.each do |trip|
          next if trips_already_saved.include?(trip.id)
          actual_trip = Trip.build_trip(trip, car.id).save
          if actual_trip.id
            # start/end locations
            TripLocation.build_trip_location(trip.start_location, actual_trip.id, TripLocation::START_LOCATION).save
            TripLocation.build_trip_location(trip.end_location, actual_trip.id, TripLocation::END_LOCATION).save

            # trip events
            trip.events.each do |vehicle_event|
              TripEvent.build_trip_events(vehicle_event, actual_trip.id).save
            end if trip.events?
          end

        end
      end
      trips_request.on(:server_error) do |resp|
        is_next = false
      end
      is_next = trips_url.present?
    end

    # go through all the trips and save them & if needed create an address too for start/end address
    
    

    true
  end
end