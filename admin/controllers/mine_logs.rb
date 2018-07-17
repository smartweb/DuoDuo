DuoChain::Admin.controllers :mine_logs do
  get :index do
    @title = "Mine_logs"
    @mine_logs = MineLog.all
    render 'mine_logs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'mine_log')
    @mine_log = MineLog.new
    render 'mine_logs/new'
  end

  post :create do
    @mine_log = MineLog.new(params[:mine_log])
    if @mine_log.save
      @title = pat(:create_title, :model => "mine_log #{@mine_log.id}")
      flash[:success] = pat(:create_success, :model => 'MineLog')
      params[:save_and_continue] ? redirect(url(:mine_logs, :index)) : redirect(url(:mine_logs, :edit, :id => @mine_log.id))
    else
      @title = pat(:create_title, :model => 'mine_log')
      flash.now[:error] = pat(:create_error, :model => 'mine_log')
      render 'mine_logs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "mine_log #{params[:id]}")
    @mine_log = MineLog.get(params[:id])
    if @mine_log
      render 'mine_logs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'mine_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "mine_log #{params[:id]}")
    @mine_log = MineLog.get(params[:id])
    if @mine_log
      if @mine_log.update(params[:mine_log])
        flash[:success] = pat(:update_success, :model => 'Mine_log', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:mine_logs, :index)) :
          redirect(url(:mine_logs, :edit, :id => @mine_log.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'mine_log')
        render 'mine_logs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'mine_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Mine_logs"
    mine_log = MineLog.get(params[:id])
    if mine_log
      if mine_log.destroy
        flash[:success] = pat(:delete_success, :model => 'Mine_log', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'mine_log')
      end
      redirect url(:mine_logs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'mine_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Mine_logs"
    unless params[:mine_log_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'mine_log')
      redirect(url(:mine_logs, :index))
    end
    ids = params[:mine_log_ids].split(',').map(&:strip)
    mine_logs = MineLog.all(:id => ids)
    
    if mine_logs.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Mine_logs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:mine_logs, :index)
  end
end
