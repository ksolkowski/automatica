class Car < Sequel::Model
  include FindBy
  plugin :validation_helpers
  one_to_many :trips
  many_to_one :user

  def validate
    validates_presence :user_id
    validates_presence :automatic_id
  end

  def self.find_by_id(id)
    self[id] rescue nil
  end

  def after_create
    puts "after_create"
    SyncTripsWorker.perform_async(self.id) # fetch all the trips!
  end

end
