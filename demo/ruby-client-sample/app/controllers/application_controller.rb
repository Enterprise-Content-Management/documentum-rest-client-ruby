class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :extract_page

  rescue_from 'Dctmclient::Exception::DctmclientException' do |exception|
    render plain: exception
  end

  @@repository = nil

  private

  def extract_page(href_having_page_params)
    uri = URI.parse(href_having_page_params)
    params = CGI.parse(uri.query)
    return params['page'].first
  end

end
