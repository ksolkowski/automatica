class Trip < Sequel::Model
  METER_TO_MILE = 0.000621371
  include FindBy
  plugin :validation_helpers
  many_to_one   :car
  one_to_many   :trip_locations
  one_to_one    :start_location, class: TripLocation.name, dataset:(proc do
    TripLocation.where(trip_id: id, tag: TripLocation::START_LOCATION)
  end)
  one_to_one    :end_location, class: TripLocation.name, dataset:(proc do
    TripLocation.where(trip_id: id, tag: TripLocation::END_LOCATION)
  end)


  set_dataset dataset.order(:started_at)

  def validate
    validates_presence :car_id
    validates_presence :automatic_id
  end

  # deal with dup cases later
  def self.build_trip(auto_model, car_id)
    trip = self.new(car_id: car_id)
    trip.automatic_id = auto_model.id
    trip.started_at = auto_model.started_at
    trip.ended_at = auto_model.ended_at
    trip.distance_m = auto_model.distance_m
    trip.fuel_cost_usd = auto_model.fuel_cost_usd
    trip.fuel_volume_l = auto_model.fuel_volume_l
    trip.average_kmpl = auto_model.average_kmpl
    trip.path = auto_model.path
    trip.score_events = auto_model.score_events
    trip.score_speeding = auto_model.score_speeding
    trip.hard_brakes = auto_model.hard_brakes
    trip.hard_accels = auto_model.hard_accels
    trip.duration_over_70_s = auto_model.duration_over_70_s
    trip.duration_over_75_s = auto_model.duration_over_75_s
    trip.duration_over_80_s = auto_model.duration_over_80_s
    trip.start_timezone = auto_model.start_timezone
    trip.end_timezone = auto_model.end_timezone
    trip.idling_time_s = auto_model.idling_time_s
    trip
  end

end
