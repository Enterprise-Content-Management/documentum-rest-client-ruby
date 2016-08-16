class FormatsController < ApplicationController
  def index
    params[:items_per_page] =4 if params[:items_per_page].nil?
    params[:page] =1 if params[:page].nil?

    @formats = @@repository.formats("items-per-page" => params[:items_per_page], "page" => params[:page])

  end
end
