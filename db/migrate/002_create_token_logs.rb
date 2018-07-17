migration 2, :create_token_logs do
  up do
    create_table :token_logs do
      column :id, Integer, :serial => true
      column :user_id, DataMapper::Property::Integer
      column :content, DataMapper::Property::String, :length => 255
      column :token, DataMapper::Property::Decimal
      column :before_token, DataMapper::Property::Decimal
      column :after_token, DataMapper::Property::Decimal
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :token_logs
  end
end
