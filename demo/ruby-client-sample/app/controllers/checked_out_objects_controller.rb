class CheckedOutObjectsController < ApplicationController
  def index
    entries = @@repository.checked_out_objects.representation_json['entries']
    @checked_out_object_entries = (entries.nil? ? [] : entries)
  end
end
