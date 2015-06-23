class OilChange < Sequel::Model
  include FindBy
  plugin :validation_helpers
  many_to_one :car
  set_dataset dataset.order(:changed_at)

  def validate
    validates_presence :car_id
    validates_presence :changed_at
  end

end
