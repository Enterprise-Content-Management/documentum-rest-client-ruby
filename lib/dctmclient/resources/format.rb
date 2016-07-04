module Dctmclient
  class Formats < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(name, params = {})
      link = find_entry_link_by(name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Format, {:params => params})
    end

  end

  class Format < SingleResource
    def initialize(response)
      super(response)
    end
  end

end