class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :mobile, String
  property :crypted_password, String
  property :name, String
  property :token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :snap_token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :snap_power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :power_logs
  has n, :token_logs
  has n, :user_data
  has n, :invite_logs
  has n, :checkin_logs

  def self.find_by_id(id)
    get(id) rescue nil
  end
  
  def self.authenticate(mobile, password)
    account = first(:mobile => mobile) if mobile.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  # 注册
  def self.sign_up(mobile, password, name)
      return false if User.first(:mobile => mobile)
      return false unless password.present?

      user = User.create(:mobile => mobile, :name=>name)
      user.crypted_password = ::BCrypt::Password.create(password) 
      user.token      = 0 
      user.snap_token = 0 
      user.power      = 0
      user.snap_power = 0

      if user.save
        PowerLog.add(user, :sign_up)
        user
      else 
        false
      end
  end

  # 是否已完善资料
  def modify?
    return true if UserDatum.first(:user_id=>id)
    false
  end

  def modify_done
    PowerLog.modify(self)
  end

  def checkin?
    return true if CheckinLog.first(:user_id=>id, :check_date => Date.today)
    false
  end

  # 签到
  def checkin
    return if checkin?
    PowerLog.checkin(self)
  end

  # 邀请好友
  def invite(invite_user_id)
    #PowerLog.checkin(self, invite_user_id)
  end

  def mobile_mark
    mobile.to_s[0,3] + "****" + mobile.to_s[6,4]
  end

  # 原力排名
  def power_position
    User.count(:power.gt => power) + 1
  end

  # 邀请奖励
  def invite_award(target_id)
    InviteLog.add(self.id, target_id)
    PowerLog.invite(self)
  end

end
