Sequel.migration do
  up do
    create_table :trip_locations do
      primary_key :id
      Integer :trip_id
      String :tag

      Decimal :lat
      Decimal :lon
      Decimal :accuracy_m
      
    end
  end

  down do
    drop_table :trip_locations
  end
end
