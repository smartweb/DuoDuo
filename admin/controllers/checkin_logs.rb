DuoChain::Admin.controllers :checkin_logs do
  get :index do
    @title = "Checkin_logs"
    @checkin_logs = CheckinLog.all
    render 'checkin_logs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'checkin_log')
    @checkin_log = CheckinLog.new
    render 'checkin_logs/new'
  end

  post :create do
    @checkin_log = CheckinLog.new(params[:checkin_log])
    if @checkin_log.save
      @title = pat(:create_title, :model => "checkin_log #{@checkin_log.id}")
      flash[:success] = pat(:create_success, :model => 'CheckinLog')
      params[:save_and_continue] ? redirect(url(:checkin_logs, :index)) : redirect(url(:checkin_logs, :edit, :id => @checkin_log.id))
    else
      @title = pat(:create_title, :model => 'checkin_log')
      flash.now[:error] = pat(:create_error, :model => 'checkin_log')
      render 'checkin_logs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "checkin_log #{params[:id]}")
    @checkin_log = CheckinLog.get(params[:id])
    if @checkin_log
      render 'checkin_logs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'checkin_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "checkin_log #{params[:id]}")
    @checkin_log = CheckinLog.get(params[:id])
    if @checkin_log
      if @checkin_log.update(params[:checkin_log])
        flash[:success] = pat(:update_success, :model => 'Checkin_log', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:checkin_logs, :index)) :
          redirect(url(:checkin_logs, :edit, :id => @checkin_log.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'checkin_log')
        render 'checkin_logs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'checkin_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Checkin_logs"
    checkin_log = CheckinLog.get(params[:id])
    if checkin_log
      if checkin_log.destroy
        flash[:success] = pat(:delete_success, :model => 'Checkin_log', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'checkin_log')
      end
      redirect url(:checkin_logs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'checkin_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Checkin_logs"
    unless params[:checkin_log_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'checkin_log')
      redirect(url(:checkin_logs, :index))
    end
    ids = params[:checkin_log_ids].split(',').map(&:strip)
    checkin_logs = CheckinLog.all(:id => ids)
    
    if checkin_logs.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Checkin_logs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:checkin_logs, :index)
  end
end
