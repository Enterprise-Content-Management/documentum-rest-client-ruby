module Dctmclient
  class GroupUsers < CollectionResource
    def initialize(response)
      super(response)
    end
  end

  class GroupUser < SingleResource
    def initialize(response)
      super(response)
    end
  end

end