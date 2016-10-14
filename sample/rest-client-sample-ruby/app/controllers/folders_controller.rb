class FoldersController < ApplicationController

  def new
  end

  def create
    begin
      find_folder_by(params[:parent_folder_id]).sub_folders.create_sub_folder('properties' => {'object_name' => params[:folder_name]})
      flash[:notice] = 'Create folder successfully'
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'This folder has already existed' if e.to_s.include?('DM_FOLDER_E_PATH_EXISTS')
    end

    redirect_to sysobjects_path(:current_folder_id => params[:parent_folder_id])
  end


  def destroy
    begin
      find_folder_by(params[:id]).delete
      session[:clipboard].delete_if { |item| item == params[:id] }
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'Some objects are checked out in this folder' if e.to_s.include?('version state conflict')
    end

    redirect_to sysobjects_path(:current_folder_id => params[:parent_folder_id], :page => params[:page])
  end

end
