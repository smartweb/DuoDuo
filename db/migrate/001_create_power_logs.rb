migration 1, :create_power_logs do
  up do
    create_table :power_logs do
      column :id, Integer, :serial => true
      column :user_id, DataMapper::Property::Integer
      column :content, DataMapper::Property::String, :length => 255
      column :power, DataMapper::Property::Decimal
      column :before_power, DataMapper::Property::Decimal
      column :after_power, DataMapper::Property::Decimal
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :power_logs
  end
end
