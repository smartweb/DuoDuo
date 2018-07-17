migration 3, :create_mine_logs do
  up do
    create_table :mine_logs do
      column :id, Integer, :serial => true
      column :total_token, DataMapper::Property::Decimal
      column :total_power, DataMapper::Property::Decimal
      column :user_count, DataMapper::Property::Integer
      column :unit_token, DataMapper::Property::Decimal
      column :mine_count, DataMapper::Property::Integer
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :mine_logs
  end
end
