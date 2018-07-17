DuoChain::Admin.controllers :power_logs do
  get :index do
    @title = "Power_logs"
    @power_logs = PowerLog.all
    render 'power_logs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'power_log')
    @power_log = PowerLog.new
    render 'power_logs/new'
  end

  post :create do
    @power_log = PowerLog.new(params[:power_log])
    if @power_log.save
      @title = pat(:create_title, :model => "power_log #{@power_log.id}")
      flash[:success] = pat(:create_success, :model => 'PowerLog')
      params[:save_and_continue] ? redirect(url(:power_logs, :index)) : redirect(url(:power_logs, :edit, :id => @power_log.id))
    else
      @title = pat(:create_title, :model => 'power_log')
      flash.now[:error] = pat(:create_error, :model => 'power_log')
      render 'power_logs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "power_log #{params[:id]}")
    @power_log = PowerLog.get(params[:id])
    if @power_log
      render 'power_logs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'power_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "power_log #{params[:id]}")
    @power_log = PowerLog.get(params[:id])
    if @power_log
      if @power_log.update(params[:power_log])
        flash[:success] = pat(:update_success, :model => 'Power_log', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:power_logs, :index)) :
          redirect(url(:power_logs, :edit, :id => @power_log.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'power_log')
        render 'power_logs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'power_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Power_logs"
    power_log = PowerLog.get(params[:id])
    if power_log
      if power_log.destroy
        flash[:success] = pat(:delete_success, :model => 'Power_log', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'power_log')
      end
      redirect url(:power_logs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'power_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Power_logs"
    unless params[:power_log_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'power_log')
      redirect(url(:power_logs, :index))
    end
    ids = params[:power_log_ids].split(',').map(&:strip)
    power_logs = PowerLog.all(:id => ids)
    
    if power_logs.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Power_logs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:power_logs, :index)
  end
end
