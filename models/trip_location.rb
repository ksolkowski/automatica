class TripLocation < Sequel::Model
  START_LOCATION = "start_location"
  END_LOCATION = "end_location"
  plugin :validation_helpers

  def validate
    validates_presence :trip_id
    validates_presence :tag
  end

  def self.build_trip_location(auto_model, trip_id, tag)
    location = self.new(trip_id: trip_id)
    location.lat = auto_model.lat
    location.lon = auto_model.lon
    location.accuracy_m = auto_model.accuracy_m
    location.tag = tag
    location
  end

end
