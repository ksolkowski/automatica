class TripEvent < Sequel::Model
  plugin :validation_helpers
  SPEEDING = 'speeding'
  HARD_ACCEL = 'hard_accel'
  HARD_BRAKE = 'hard_brake'

  def validate
    validates_presence :trip_id
  end

  # the actual trip event from the api is polymorphic, but I'm lazy.
  def self.build_trip_events(auto_model, trip_id)
    trip_event = self.new(trip_id: trip_id)
    trip_event.type = auto_model.type
    trip_event.g_force = auto_model.g_force if auto_model.respond_to?(:g_force)
    trip_event.lat = auto_model.lat if auto_model.respond_to?(:lat)
    trip_event.lon = auto_model.lon if auto_model.respond_to?(:lon)
    trip_event.lon = auto_model.lon if auto_model.respond_to?(:lon)
    trip_event.started_at = auto_model.started_at if auto_model.respond_to?(:started_at)
    trip_event.ended_at = auto_model.ended_at if auto_model.respond_to?(:ended_at)
    trip_event.velocity_kph = auto_model.velocity_kph if auto_model.respond_to?(:velocity_kph)
    trip_event.start_distance_m = auto_model.start_distance_m if auto_model.respond_to?(:start_distance_m)
    trip_event.end_distance_m = auto_model.end_distance_m if auto_model.respond_to?(:end_distance_m)

    trip_event
  end

end
