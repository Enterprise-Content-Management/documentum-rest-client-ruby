class SearchesController < ApplicationController

  helper_method :find_cabinet_by

  def index
    params[:items_per_page] = 15 if params[:items_per_page].nil?
    params[:page] = 1 if params[:page].nil?


    if params[:search_type]
      @result = if params[:search_type] == 'DQL'
                  @@repository.query(params[:dql], 'items-per-page' => params[:items_per_page], 'page' => params[:page])
                elsif params[:search_type] == 'Simple'
                  @@repository.search('q' => params[:q], 'items-per-page' => params[:items_per_page], 'page' => params[:page])
                else
                  nil
                end
    end

    params[:search_type] = 'DQL' if params[:search_type].nil?
    params[:dql] = 'select * from dm_document' if params[:dql].nil?
    params[:q] = 'REPO' if params[:q].nil?

  end


  private

  def find_cabinet_by(object_id)
    link = @@repository.find_link_by(Dctmclient::Resources::Link::RELATIONS[:self])
    link.href = link.href + "/objects/#{object_id}"
    response = Dctmclient::Net::Response.new(200, nil)
    object = Dctmclient::Resources::AbstractResource.new(response).link_to(link, :SysObject)
    cabinet_link = object.find_link_by(Dctmclient::Resources::Link::RELATIONS[:cabinet])
    return cabinet_link.href.split('/cabinets/')[1]
  end
end
