class TokenLog
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :user_id, Integer
  property :content, String
  property :token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :before_token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :after_token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :created_at, DateTime

  belongs_to :user

  after :save, :update_user

  def self.add(user, mine_token)
    return false unless mine_token > 0

    log = TokenLog.create(:user_id => user.id)
    log.before_token = user.token
    log.token        = mine_token
    log.after_token  = log.before_token + log.token
    log.content      = ""
    log.save
  end


  def update_user
    return false unless after_token

    if user.token < after_token
      user.token = after_token
      return true if user.save
    else
      false
    end
  end
end
