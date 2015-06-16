Sequel.migration do
  up do
    create_table :trips do
      primary_key :id

      String :automatic_id
      String :start_timezone
      String :end_timezone

      Integer :car_id
      Integer :hard_brakes
      Integer :hard_accels
      Integer :duration_over_70_s
      Integer :duration_over_75_s
      Integer :duration_over_80_s
      Integer :idling_time_s

      Decimal :distance_m
      Decimal :fuel_cost_usd
      Decimal :fuel_volume_l
      Decimal :average_kmpl
      Decimal :score_events
      Decimal :score_speeding

      Datetime :started_at
      Datetime :ended_at
    end
  end

  down do
    drop_table :trips
  end
end
