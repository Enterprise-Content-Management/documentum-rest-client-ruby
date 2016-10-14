class CheckedOutObjectsController < ApplicationController

  def index
    @rest_checked_out_objects = @@repo.checked_out_objects('inline' => true)
  end

end
