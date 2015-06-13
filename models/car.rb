class Car < Sequel::Model
  plugin :validation_helpers

  def validate
    validates_presence :user_id
    validates_presence :automatic_id
  end

end
