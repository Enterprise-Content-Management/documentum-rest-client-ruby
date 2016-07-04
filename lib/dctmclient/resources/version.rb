module Dctmclient
  class Versions < CollectionResource
    def initialize(response)
      super(response)
    end
  end

  class Version < SingleResource
    def initialize(response)
      super(response)
    end
  end

end