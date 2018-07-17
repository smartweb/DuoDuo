migration 5, :create_invite_logs do
  up do
    create_table :invite_logs do
      column :id, Integer, :serial => true
      column :user_id, DataMapper::Property::Integer
      column :invite_user_id, DataMapper::Property::Integer
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :invite_logs
  end
end
