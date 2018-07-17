DuoChain::App.controllers :base do
  get :index, :map => "/" do
    @token_users = User.all(:order => :token.desc, :limit=>30)
    @power_users = User.all(:order => :power.desc, :limit=>30)

    render "index"
  end
 
  get :login, :map => '/login' do
    @login_signup_page = true
    render 'login'
  end

  post :login, :map => '/login' do
    mobile    = params[:mobile].to_s
    password  = params[:password].to_s
    return "请输入手机号和密码" unless (mobile.present? || password.present?)
    account = User.authenticate(mobile, password)
    return "密码错误" if account.nil?

    set_current_account(account)
    redirect url(:base, :index)
  end

  get :logout, :map =>'/logout' do
    set_current_account(nil)
    redirect url(:base, :index)
  end

  get :checkin, :map => '/checkin' do
    redirect url(:base, :login) unless current_account

    account = current_account
    account.checkin
    redirect url(:base, :power)
  end

  get :signup, :map => '/signup' do
    @login_signup_page = true
    @inviter = User.get(params[:inviter_id].to_i)
    session[:form] = {} unless session[:form]
    render "signup"
  end

  post :signup, :map => '/signup' do
    name    = params[:name]
    mobile  = params[:mobile]
    password= params[:password]
    
    msg     = nil
    msg     = "该手机号已注册" if User.first(:mobile=>mobile)

    if msg.nil?
      account = User.sign_up(mobile, password, name)
      set_current_account(account)

      if params[:inviter].to_i > 0
        inviter = User.get(params[:inviter].to_i)
        inviter.invite_award(account.id)
      end

      session[:form] = nil
      redirect url(:base, :index)
    else
      session[:form] = {:name => name, :mobile => mobile, :password => password, :msg=> msg}
      redirect url(:base, :signup)
    end
  end

  get :modify, :map => '/modify' do
    redirect url(:base, :login) unless current_account

    render 'modify'
  end

  post :modify, :map => '/modify' do
    redirect url(:base, :login) unless current_account

    data = UserDatum.new
    data.user_id  = current_account.id
    data.age      = params[:age].to_i
    data.sex      = params[:sex].to_i
    data.marry    = params[:marry].to_i
    data.city     = params[:city]
    data.salary   = params[:salary].to_i
    data.when_to_buy = params[:when]
    data.brand    = params[:brand]
    data.budget   = params[:budget].to_i
    current_account.modify_done if data.save

    redirect url(:base, :power)
  end

  get :power, :map => '/power' do
    render 'power'
  end

  get :about, :map => '/about' do
    render 'about'
  end

  get :invite, :map => '/invite' do
    redirect url(:base, :login) unless current_account

    render 'invite'
  end

end
