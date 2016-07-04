module Dctmclient
  class Types < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(typename, params = {})
      link = find_entry_link_by(typename, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Type, {:params => params})
    end

  end

  class Type < SingleResource
    def initialize(response)
      super(response)
    end
  end

end