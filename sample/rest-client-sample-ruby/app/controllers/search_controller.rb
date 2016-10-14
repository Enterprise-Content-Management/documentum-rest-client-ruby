class SearchController < ApplicationController

  def index
    if !params[:search_text].blank?
      @rest_search_results = @@repo.search('inline' => true, 'q' => params[:search_text])
    end
  end

end
