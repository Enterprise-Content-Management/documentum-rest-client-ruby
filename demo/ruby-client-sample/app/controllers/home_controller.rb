class HomeController < ApplicationController
  def index
  end

  def repositories
    session[:rest_services_url] = params[:rest_services_url]
    home = Dctmclient::Resources::Home.new(params[:rest_services_url])
    @repo_names = home.repositories.representation_json['entries'].map { |entry| entry['title'] }
  end


  def login
    repository = Dctmclient::Resources::Home.new(session[:rest_services_url]).repositories.find(params['repo_name'], params['username'], params['password'])
    @@repository = repository
    session[:username], session[:password] = params['username'], params['password']
    redirect_to :action => :demo
  end

  def demo
    @current_user = @@repository.current_user.representation_json
  end

end
