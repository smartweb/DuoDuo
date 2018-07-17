migration 8, :create_users do
  up do
    create_table :users do
      column :id, Integer, :serial => true
      column :mobile, DataMapper::Property::String, :length => 255
      column :crypted_password, DataMapper::Property::String, :length => 255
      column :name, DataMapper::Property::String, :length => 255
      column :token, DataMapper::Property::Decimal, :precision => 12, :scale => 10, :default => 0
      column :power, DataMapper::Property::Decimal, :precision => 12, :scale => 10, :default => 0
      column :snap_token, DataMapper::Property::Decimal, :precision => 12, :scale => 10, :default => 0
      column :snap_power, DataMapper::Property::Decimal, :precision => 12, :scale => 10, :default => 0
      column :created_at, DataMapper::Property::DateTime
      column :updated_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :users
  end
end
