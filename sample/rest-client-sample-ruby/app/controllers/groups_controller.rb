class GroupsController < ApplicationController

  def index
    @page = params[:page].blank? ? 1 : params[:page]
    @rest_groups = @@repo.groups(
        'include-total' => true,
        'inline' => true,
        'items-per-page' => session[:items_per_page],
        'page' => @page
    )
  end

end
