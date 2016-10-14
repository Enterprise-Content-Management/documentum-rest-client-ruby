class ClipboardController < ApplicationController

  def add
    session[:clipboard] << params[:sys_object_id]
    session[:clipboard].uniq!
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id], :page => params[:page])
  end
end
