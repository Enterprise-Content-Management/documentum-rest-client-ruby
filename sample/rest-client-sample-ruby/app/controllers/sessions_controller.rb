class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create

    if params[:username].blank? || params[:password].blank?
      redirect_to new_session_url, :alert => 'Credential is mandatory!'
      return
    end

    begin
      @@repo = Dctmclient::Resources::Home.new(rest_services_config['rest_services']['home_url']).repositories.find(rest_services_config['rest_services']['repository'], params[:username], params[:password])

      session[:items_per_page] = 16
      session[:include_total] = true
      session[:clipboard] = []

      redirect_to users_path
      return

    rescue Dctmclient::Exception::DctmclientRequestException => e
      if e.to_s.include?('code:401')
        redirect_to new_session_url, :alert => 'Bad credential! Try again.'
        return
      end
    end
  end

  def destroy
    @@repo = nil
    session[:items_per_page] = nil
    session[:include_total] = nil
    session[:clipboard].clear
    redirect_to new_session_url
  end

  private

  def rest_services_config
    YAML.load_file(Rails.root.join('config/rest_services.yml'))
  end


end
