Sequel.migration do
  up do
    create_table :cars do
      primary_key :id
      String :name
      Integer :user_id
    end
  end

  down do
    drop_table :cars
  end
end
