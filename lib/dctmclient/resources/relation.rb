module Dctmclient
  class Relations < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(id, params = {})
      link = find_entry_link_by(id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Relation, {:params => params})
    end

    def create(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :Relation, {:post_body => attrs, :params => params})
    end

  end

  class Relation < SingleResource
    def initialize(response)
      super(response)
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'delete', :Resource, {:params => params})
    end
  end

end