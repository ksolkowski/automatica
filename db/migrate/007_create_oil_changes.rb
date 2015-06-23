Sequel.migration do
  up do
    create_table :oil_changes do
      primary_key :id

      Integer  :car_id
      Datetime :changed_at
      String   :brand_name
      Decimal  :quantity
      
    end
  end

  down do
    drop_table :oil_changes
  end
end
