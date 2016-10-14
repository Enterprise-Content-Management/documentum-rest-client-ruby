class DocumentsController < ApplicationController

  def new
  end

  def create
    ap params
    uploaded_file = params[:uploaded_file]
    find_folder_by(params[:parent_folder_id]).create_document_with_primary_content(uploaded_file.original_filename, uploaded_file.read)
    redirect_to sysobjects_path(:current_folder_id => params[:parent_folder_id])
  end

end
