class GroupsController < ApplicationController
  def index
    params[:items_per_page] =4 if params[:items_per_page].nil?
    params[:page] =1 if params[:page].nil?

    @groups = @@repository.users("items-per-page" => params[:items_per_page], "page" => params[:page])
  end
end
