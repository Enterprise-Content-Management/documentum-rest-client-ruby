class CabinetsController < ApplicationController

  def index
    @page = params[:page] ? params[:page] : 1

    @rest_cabinets = @@repo.cabinets(
        'inline' => true,
        'include-total' => true,
        'items-per-page' => session[:items_per_page],
        :page => @page
    )
    @total = @rest_cabinets.representation_json['total']
  end

  def new
  end

  def create
    begin
      @@repo.cabinets.create('properties' => {'object_name' => params[:cabinet_name]})
      flash[:notice] = 'Create cabinet successfully.'
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'The cabinet has already existed' if e.to_s.include?('DM_FOLDER_E_PATH_EXISTS')
    end
    redirect_to cabinets_path(:page => params[:page])
  end

  def edit
    @rest_cabinet = find_folder_by(params[:id])
  end


  def update
    begin
      find_folder_by(params[:id]).update('properties' => {'object_name' => params[:cabinet_name]})
      flash[:notice] = 'Save successfully'
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'The cabinet name has already existed' if e.to_s.include?('DM_FOLDER_E_PATH_EXISTS')
    end

    redirect_to cabinets_path(:page => params[:page])
  end

  def destroy
    begin
      @@repo.cabinets('items-per-page' => params[:total]).find(params[:id]).delete
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'Some objects are checked out in this cabinet' if e.to_s.include?('version state conflict')
    end

    redirect_to cabinets_path(:page => params[:page])
  end

end
