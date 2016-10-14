class UsersController < ApplicationController
  def index
    @rest_users = @@repo.users('inline' => true, 'include-total' => true, 'items-per-page' => 100, :page => params[:page] ? params[:page] : 1)
    @total = @rest_users.representation_json['total']
  end

  def new
  end

  def create
    begin
      @@repo.users.create('properties' => {'user_name' => params[:user_name], 'user_login_name' => params[:user_name]})
      flash[:notice] = 'Create successfully'
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'The user name has existed' if e.to_s.include?('DM_USER_E_EXISTING_USER_NAME')
      flash[:alert] = 'User must have name' if e.to_s.include?('DM_USER_E_MUST_HAVE_NAME')
    end
    redirect_to users_path
  end

  def edit
    @rest_user = @@repo.users('items-per-page' => params[:total]).find(params[:id])
  end

  def update
    @@repo.users('items-per-page' => params[:total])
        .find(params[:id])
        .update(
            'properties' =>
                {
                    'user_address' => params[:user_address]
                }
        )
    redirect_to users_path, :notice => 'Save successfully'
  end

  def destroy
    @@repo.users('items-per-page' => params[:total]).find(params[:id]).delete
    redirect_to users_path, :notice => 'Delete successfully'
  end
end
