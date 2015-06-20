class TripSerializer < ActiveModel::Serializer
  attributes :id, :automatic_id, :start_timezone, :end_timezone, :path, :hard_brakes, :hard_accels, 
             :duration_over_70_s, :duration_over_75_s, :duration_over_80_s, :idling_time_s, :distance_m, 
             :fuel_cost_usd, :fuel_volume_l, :average_kmpl, :score_events, :score_speeding, :started_at, :ended_at,
             :start_location, :end_location

  def trip_locations
    @trip_locations ||= object.trip_locations
  end
  def end_location
    trip_locations.find do |location|
      location.tag == TripLocation::END_LOCATION
    end
  end
  def start_location
    trip_locations.find do |location|
      location.tag == TripLocation::START_LOCATION
    end
  end
end