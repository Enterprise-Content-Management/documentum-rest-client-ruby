class SysobjectsController < ApplicationController

  def index
    @page = params[:page].blank? ? 1 : params[:page]
    @rest_sys_objects = find_folder_by(params[:current_folder_id])
                            .sys_objects(
                                'inline' => true,
                                'include-total' => true,
                                'items-per-page' => session[:items_per_page],
                                'page' => @page
                            )
  end

  def destroy
    find_sysobject_by(params[:id]).delete
    session[:clipboard].delete_if { |item| item == params[:id] }
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id], :page => params[:page])
  end

  def copy
    rest_folder = find_folder_by(params[:current_folder_id])
    begin
      session[:clipboard].each { |sys_object_id| rest_folder.copy_sys_object(find_sysobject_by(sys_object_id)) }
      flash[:notice] = 'Copy successfully'
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'The folder to be copied and destination folder cannot be same' if e.to_s.include?('same')
    end
    session[:clipboard].clear
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id])
  end

  def link
    rest_folder = find_folder_by(params[:current_folder_id])
    begin
      session[:clipboard].each { |sys_object_id| find_sysobject_by(sys_object_id).linking_to(rest_folder) }
    rescue Dctmclient::Exception::DctmclientRequestException => e
      flash[:alert] = 'This object has been linked to this folder' if e.to_s.include?('DM_SYSOBJECT_E_ALREADY_LINKED')
    end
    session[:clipboard].clear
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id])
  end

  def move
    rest_folder = find_folder_by(params[:current_folder_id])

    begin
      session[:clipboard].each { |sys_object_id|
        rest_sys_object = find_sysobject_by(sys_object_id)
        src_folder = find_folder_by(rest_sys_object.properties['i_folder_id'].first)
        rest_sys_object.move(src_folder, rest_folder)
      }
    rescue Dctmclient::Exception::DctmclientException => e
      flash[:alert] = 'This object has been linked to this folder' if e.to_s.include?('DM_SYSOBJECT_E_ALREADY_LINKED')
    end

    session[:clipboard].clear
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id])
  end

  def cancel_check_out
    find_sysobject_by(params[:id]).cancel_check_out
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id], :page => params[:page])
  end

  def check_out
    find_sysobject_by(params[:id]).check_out
    redirect_to sysobjects_path(:current_folder_id => params[:current_folder_id], :page => params[:page])
  end

  def upload_file_for_check_in
    rest_sys_object = find_sysobject_by(params[:id])
    @check_in_policies = supported_check_in_policy(rest_sys_object)
  end

  def check_in
    rest_sys_object = find_sysobject_by(params[:sys_object_id])
    uploaded_file = params[:uploaded_file]

    if uploaded_file.blank?
      flash[:alert] = 'No document is selected'
      redirect_to sysobjects_path(:current_folder_id => params[:parent_folder_id], :page => params[:page])
      return
    end

    case params[:check_in_policy]
      when 'major'
        rest_sys_object.check_in_next_major(uploaded_file.read)
      when 'minor'
        rest_sys_object.check_in_next_minor(uploaded_file.read)
      when 'branch'
        rest_sys_object.check_in_branch_version(uploaded_file.read)
    end

    redirect_to sysobjects_path(:current_folder_id => params[:parent_folder_id], :page => params[:page])
  end


  private

  def supported_check_in_policy(rest_sys_object)
    policies = []
    policies << 'major' if rest_sys_object.find_link_by(Dctmclient::Resources::Link::RELATIONS[:check_in_next_major])
    policies << 'minor' if rest_sys_object.find_link_by(Dctmclient::Resources::Link::RELATIONS[:check_in_next_minor])
    policies << 'branch' if rest_sys_object.find_link_by(Dctmclient::Resources::Link::RELATIONS[:check_in_branch_version])
    return policies
  end


end
