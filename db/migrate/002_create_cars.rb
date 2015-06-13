Sequel.migration do
  up do
    create_table :cars do
      primary_key :id
      Integer :user_id
      Integer :year

      String :automatic_id
      String :display_name
      String :submodel
      String :display_model
      String :make
      String :color
    end
  end

  down do
    drop_table :cars
  end
end
