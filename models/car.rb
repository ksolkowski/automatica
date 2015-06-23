class Car < Sequel::Model
  include FindBy
  plugin :validation_helpers
  one_to_many :trips
  many_to_one :user
  one_to_many :oil_changes


  def sync_trips
    SyncTripsWorker.perform_async(self.id) # fetch all the trips!
  end

  def validate
    validates_presence :user_id
    validates_presence :automatic_id
  end

  def self.find_by_id(id)
    self[id] rescue nil
  end

  # returns meters
  def distance_since(date=Time.zone.now)
    trips_dataset.where("ended_at > ?", date).sum(:distance_m) || 0
  end

  def miles_since(date)
    distance_since(date) * Trip::METER_TO_MILE
  end

  def last_oil_change
    oil_changes.last
  end

  def distance_since_last_change
    if last_oil_change.present?
      distance_since(last_oil_change.changed_at)
    else
      trips_dataset.sum(:distance_m) || 0
    end
  end

  def after_create
    sync_trips
  end

end
