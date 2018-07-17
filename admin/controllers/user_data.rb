DuoChain::Admin.controllers :user_data do
  get :index do
    @title = "User_data"
    @user_data = UserDatum.all
    render 'user_data/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'user_datum')
    @user_datum = UserDatum.new
    render 'user_data/new'
  end

  post :create do
    @user_datum = UserDatum.new(params[:user_datum])
    if @user_datum.save
      @title = pat(:create_title, :model => "user_datum #{@user_datum.id}")
      flash[:success] = pat(:create_success, :model => 'UserDatum')
      params[:save_and_continue] ? redirect(url(:user_data, :index)) : redirect(url(:user_data, :edit, :id => @user_datum.id))
    else
      @title = pat(:create_title, :model => 'user_datum')
      flash.now[:error] = pat(:create_error, :model => 'user_datum')
      render 'user_data/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "user_datum #{params[:id]}")
    @user_datum = UserDatum.get(params[:id])
    if @user_datum
      render 'user_data/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'user_datum', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "user_datum #{params[:id]}")
    @user_datum = UserDatum.get(params[:id])
    if @user_datum
      if @user_datum.update(params[:user_datum])
        flash[:success] = pat(:update_success, :model => 'User_datum', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:user_data, :index)) :
          redirect(url(:user_data, :edit, :id => @user_datum.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'user_datum')
        render 'user_data/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'user_datum', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "User_data"
    user_datum = UserDatum.get(params[:id])
    if user_datum
      if user_datum.destroy
        flash[:success] = pat(:delete_success, :model => 'User_datum', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'user_datum')
      end
      redirect url(:user_data, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'user_datum', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "User_data"
    unless params[:user_datum_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'user_datum')
      redirect(url(:user_data, :index))
    end
    ids = params[:user_datum_ids].split(',').map(&:strip)
    user_data = UserDatum.all(:id => ids)
    
    if user_data.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'User_data', :ids => "#{ids.join(', ')}")
    end
    redirect url(:user_data, :index)
  end
end
