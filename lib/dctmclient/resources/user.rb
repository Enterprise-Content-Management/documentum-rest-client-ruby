module Dctmclient
  class Users < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(name, params = {})
      link = find_entry_link_by(name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :User, {:params => params})
    end

  end

  class User < SingleResource
    def initialize(response)
      super(response)
    end

    def default_folder(params = {})
      link = find_link_by(Link::REL_NAMES[:user_default_folder])
      return navigate(link, 'get', :Folder, {:params => params})
    end

  end

end