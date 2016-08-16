class ObjectsController < ApplicationController

  helper_method :is_dm_sys_object?

  def index
    params[:items_per_page] =4 if params[:items_per_page].nil?
    params[:page] =1 if params[:page].nil?
    @objects = @@repository.cabinets.find(params[:cabinet_id]).sys_objects('items-per-page' => params[:items_per_page], 'page' => params[:page])
  end

  def new
  end

  def show
    ap params
    object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects('items-per-page' => 1000).find(params[:id])
    @checked_out = object.checked_out?
    @object = object.representation_json
  end

  def create
    # @@repository.cabinets.find(params[:cabinet_id]).create_sys_object(params[:object_name], '')
    @@repository.cabinets.find(params[:cabinet_id]).create_sys_object("properties" => {"object_name" => params[:object_name], "r_object_type" => params[:object_type]})

    redirect_to :action => :index, :controller => :objects, :cabinet_id => params[:cabinet_id]
  end

  def edit
    @object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id]).representation_json
  end

  def update
    @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id]).update({"properties" => {"object_name" => params[:object_name]}})
    redirect_to :action => :index, :controller => :objects, :cabinet_id => params[:cabinet_id]
  end

  def destroy
    @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id]).delete
    redirect_to :action => :index, :controller => :objects, :cabinet_id => params[:cabinet_id]
  end

  def versions
    @object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id])
    @versions = @object.versions
    @checked_out = @object.checked_out?
  end

  def checkout
    object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id])
    object.check_out
    redirect_to :action => :versions, :controller => :objects, :id => params[:id], :cabinet_id => params[:cabinet_id]
  end

  def cancel_checkout
    object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id])
    object.cancel_check_out
    redirect_to :action => :versions, :controller => :objects, :id => params[:id], :cabinet_id => params[:cabinet_id]
  end

  def checkin
    uploaded_io = params['file']
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    object = @@repository.cabinets.find(params[:cabinet_id]).sys_objects.find(params[:id]).send("check_in_next_#{params[:version]}", File.read(Rails.root.join('public', 'uploads', uploaded_io.original_filename)))
    redirect_to :actoin => :versions, :controller => :objects, :id => object.representation_json['properties']['r_object_id'], :cabinet_id => params[:cabinet_id]
  end

  private

  def is_dm_sys_object?(object)
    return ['dm_document', 'dm_sysobject'].include?(object['properties']['r_object_type'])
  end
end
