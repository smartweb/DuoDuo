migration 6, :create_checkin_logs do
  up do
    create_table :checkin_logs do
      column :id, Integer, :serial => true
      column :user_id, DataMapper::Property::Integer
      column :check_date, DataMapper::Property::Date
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :checkin_logs
  end
end
