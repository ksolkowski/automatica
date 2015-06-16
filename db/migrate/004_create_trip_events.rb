Sequel.migration do
  up do
    create_table :trip_events do
      primary_key :id

      Integer :trip_id
      Datetime :started_at
      Datetime :ended_at
      Decimal :g_force
      Decimal :lat
      Decimal :lon
      Decimal :velocity_kph
      Decimal :start_distance_m
      Decimal :end_distance_m

      String :type
    end
  end

  down do
    drop_table :trip_events
  end
end
