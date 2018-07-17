DuoChain::Admin.controllers :token_logs do
  get :index do
    @title = "Token_logs"
    @token_logs = TokenLog.all
    render 'token_logs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'token_log')
    @token_log = TokenLog.new
    render 'token_logs/new'
  end

  post :create do
    @token_log = TokenLog.new(params[:token_log])
    if @token_log.save
      @title = pat(:create_title, :model => "token_log #{@token_log.id}")
      flash[:success] = pat(:create_success, :model => 'TokenLog')
      params[:save_and_continue] ? redirect(url(:token_logs, :index)) : redirect(url(:token_logs, :edit, :id => @token_log.id))
    else
      @title = pat(:create_title, :model => 'token_log')
      flash.now[:error] = pat(:create_error, :model => 'token_log')
      render 'token_logs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "token_log #{params[:id]}")
    @token_log = TokenLog.get(params[:id])
    if @token_log
      render 'token_logs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'token_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "token_log #{params[:id]}")
    @token_log = TokenLog.get(params[:id])
    if @token_log
      if @token_log.update(params[:token_log])
        flash[:success] = pat(:update_success, :model => 'Token_log', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:token_logs, :index)) :
          redirect(url(:token_logs, :edit, :id => @token_log.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'token_log')
        render 'token_logs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'token_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Token_logs"
    token_log = TokenLog.get(params[:id])
    if token_log
      if token_log.destroy
        flash[:success] = pat(:delete_success, :model => 'Token_log', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'token_log')
      end
      redirect url(:token_logs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'token_log', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Token_logs"
    unless params[:token_log_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'token_log')
      redirect(url(:token_logs, :index))
    end
    ids = params[:token_log_ids].split(',').map(&:strip)
    token_logs = TokenLog.all(:id => ids)
    
    if token_logs.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Token_logs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:token_logs, :index)
  end
end
