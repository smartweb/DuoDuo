class InviteLog
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :user_id, Integer
  property :invite_user_id, Integer
  property :created_at, DateTime

  def self.add(user_id, target_id)
    create(:user_id => user_id, :invite_user_id => target_id)
  end
end
