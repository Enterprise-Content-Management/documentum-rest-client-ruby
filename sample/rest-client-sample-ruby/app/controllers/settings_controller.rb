class SettingsController < ApplicationController
  def edit
  end

  def update
    session[:items_per_page] = params[:items_per_page]
    session[:include_total] = (params[:include_total] ? true : false)
    flash[:notice] = 'Update setting successfully!'
    redirect_to edit_setting_path(0)
  end


end
