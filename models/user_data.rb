class UserDatum
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :user_id, Integer
  property :hash_id, String
  property :sex, Integer
  property :age, Integer
  property :city, String
  property :marry, Integer
  property :salary, Integer
  property :when_to_buy, Integer
  property :budget, Integer
  property :brand, String
  property :created_at, DateTime
end
