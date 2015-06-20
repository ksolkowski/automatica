Sequel.migration do
  up do
    alter_table :users do
      add_index :automatic_id
    end

    alter_table :trips do
      add_index :car_id
    end
    alter_table :cars do
      add_index :user_id
    end
    alter_table :trip_locations do
      add_index :trip_id
      add_index [:trip_id, :tag]
    end
  end

  down do

    alter_table :users do
      drop_index :automatic_id
    end
    alter_table :trips do
      drop_index :car_id
    end
    alter_table :cars do
      drop_index :user_id
    end
    alter_table :trip_locations do
      drop_index :trip_id
      drop_index [:trip_id, :tag]
    end
  end
end
