class CarSerializer < ActiveModel::Serializer
  attributes :display_name, :year, :make, :display_model, :submodel, :last_oil_change, :distance_since_last_change

  def distance_since_last_change
    object.distance_since_last_change
  end
end