class UsersController < ApplicationController

  # helper_method :extract_page

  def index
    params[:items_per_page] =4 if params[:items_per_page].nil?
    params[:page] =1 if params[:page].nil?

    @users = @@repository.users("items-per-page" => params[:items_per_page], "page" => params[:page])

  end

  def show
    @user = @@repository.users.find(params[:id]).representation_json
  end

end
