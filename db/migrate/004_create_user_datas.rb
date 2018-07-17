migration 4, :create_user_datas do
  up do
    create_table :user_data do
      column :id, Integer, :serial => true
      column :user_id, DataMapper::Property::Integer
      column :hash_id, DataMapper::Property::String, :length => 255
      column :sex, DataMapper::Property::Integer
      column :age, DataMapper::Property::Integer
      column :city, DataMapper::Property::String, :length => 255
      column :marry, DataMapper::Property::Integer
      column :salary, DataMapper::Property::Integer
      column :when_to_buy, DataMapper::Property::Integer
      column :budget, DataMapper::Property::Integer
      column :brand, DataMapper::Property::String, :length => 255
      column :created_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :user_data
  end
end
