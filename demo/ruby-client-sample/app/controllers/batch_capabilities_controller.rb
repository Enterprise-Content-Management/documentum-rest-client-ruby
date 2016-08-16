class BatchCapabilitiesController < ApplicationController
  def index
    @batch_capabilites = @@repository.batch_capabilities.representation_json
  end
end
