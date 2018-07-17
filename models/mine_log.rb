class MineLog
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :total_token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :total_power, Decimal, :precision => 20, :scale => 10, :default => 0
  property :user_count, Integer
  property :unit_token, Decimal, :precision => 20, :scale => 10, :default => 0
  property :mine_count, Integer
  property :created_at, DateTime

  MINE_TOKEN = 1000

  # 每30分钟分矿
  def self.daily_mine
    mine = MineLog.new(:total_token => MINE_TOKEN)
    mine.user_count   = User.count(:power.gt=>0)
    mine.total_power  = User.all(:power.gt=>0).sum(:power)
    mine.unit_token   = (mine.total_token / mine.total_power).round(10)
    mine.mine_count   = MineLog.count + 1
    mine.save

    User.all(:power.gt => 0).each do |user|
      mine_token = user.power * mine.unit_token
      TokenLog.add(user, mine_token)
    end

  end

end
