class CheckinLog
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :user_id, Integer
  property :check_date, Date
  property :created_at, DateTime

  belongs_to :user
end
