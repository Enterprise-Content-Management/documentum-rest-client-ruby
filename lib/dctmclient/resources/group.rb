module Dctmclient
  class Groups < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(name, params = {})
      link = find_entry_link_by(name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Group, {:params => params})
    end
  end

  class Group < SingleResource
    def initialize(response)
      super(response)
    end

    def users(params = {})
      link = find_link_by(Link::REL_NAMES[:users])
      return navigate(link, 'get', :GroupUsers, {:params => params})
    end

    def sub_groups(params = {})
      link = find_link_by(Link::REL_NAMES[:groups])
      return navigate(link, 'get', :SubGroups, {:params => params})
    end

  end

end