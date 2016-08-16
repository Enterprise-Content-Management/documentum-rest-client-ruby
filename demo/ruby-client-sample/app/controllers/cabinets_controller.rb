class CabinetsController < ApplicationController

  def index
    @cabinets = @@repository.cabinets.representation_json['entries']
    @cabinets ||= []
  end

  def show
    @cabinet = @@repository.cabinets.find(params[:id]).representation_json
  end

  def new
  end

  def update
    @@repository.cabinets.find(params[:id]).update({"properties" => {"object_name" => params[:name], "title" => params[:title]}})
    redirect_to :action => :index, :controller => :cabinets
  end

  def edit
    @cabinet = @@repository.cabinets.find(params[:id]).representation_json
  end

  def create
    @@repository.cabinets.create({"properties" => {"object_name" => params[:cabinet_name]}})
    redirect_to :action => :index, :controller => :cabinets
  end

  def destroy
    @@repository.cabinets.find(params[:id]).delete
    redirect_to :action => :index, :controller => :cabinets
  end

end
