class PowerLog
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :user_id, Integer
  property :content, String
  property :power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :before_power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :after_power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :created_at, DateTime

  DICT  = {:sign_up => 50, :checkin => 10, :modify => 300, :invite => 200}
  
  belongs_to :user

  after :save, :update_user

  def self.add(user, action = :sign_up)
    
    log = PowerLog.create(:user_id => user.id)
    log.before_power = user.power
    log.power        = DICT[action]
    log.after_power  = log.before_power + log.power
    log.content      = action.to_s
    log.save
  end

  def self.sign_up(user)
    PowerLog.add(user, :sign_up)
  end

  def self.checkin(user)
    log = CheckinLog.create(:user_id=>user.id, :check_date => Date.today)
    PowerLog.add(user, :checkin)
  end

  def self.invite(user)
    PowerLog.add(user, :invite)
  end

  def self.modify(user)
    PowerLog.add(user, :modify)
  end



  def update_user
    return false unless after_power

    if user.power < after_power 
      user.power = after_power 
      return true if user.save
    else
      false
    end
  end

end
