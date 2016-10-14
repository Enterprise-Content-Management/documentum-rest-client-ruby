class ApplicationController < ActionController::Base
  protect_from_forgery


  @@repo = nil

  before_action :require_login

  helper_method :signed_in?, :current_user, :extract_page, :format_date_time,
                :find_document_by, :find_folder_by, :find_sysobject_by


  #
  # rescue_from Exception do |exception|
  #   render plain: 'Sorry, there are something wrong with File Manager, we will address this issue ASAP.'
  # end

  protected


  def require_login
    if @@repo.nil?
      redirect_to new_session_url
    end
  end

  def signed_in?
    !@@repo.nil?
  end

  def current_user
    @@repo.current_user.properties
  end

  def extract_page(href_having_page_params)
    uri = URI.parse(href_having_page_params)
    params = CGI.parse(uri.query)
    return params['page'].first
  end

  def format_date_time(date_time)
    d = DateTime.parse(date_time)
    d.strftime('%F') + ' ' + d.strftime('%T')
  end

  def find_folder_by(id)
    link = @@repo.find_link_by(Dctmclient::Resources::Link::RELATIONS[:self])
    link.href += "/folders/#{id}"
    @@repo.link_to(link, :Folder)
  end

  def default_root_folder
    @@repo.current_user.default_folder
  end


  # def file_extension_by(full_qualified_name)
  #   ext = full_qualified_name.split('.').last
  #   ['txt', 'pdf'].include?(ext) ? ext : nil
  # end

  def find_document_by(id)
    link = @@repo.find_link_by(Dctmclient::Resources::Link::RELATIONS[:self])
    link.href += "/documents/#{id}"
    @@repo.link_to(link, :Document)
  end

  def find_sysobject_by(id)
    link = @@repo.find_link_by(Dctmclient::Resources::Link::RELATIONS[:self])
    link.href += "/objects/#{id}"
    @@repo.link_to(link, :SysObject)
  end

  # def is_folder?(rest_sys_object)
  #   rest_sys_object.properties['r_object_type'] == 'dm_folder'
  # end
  #
  # def is_document?(rest_sys_object)
  #   rest_sys_object.properties['r_object_type'] == 'dm_document'
  # end


end
