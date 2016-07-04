require_relative './sys_object'

module Dctmclient
  class Documents < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(id, params = {})
      link = find_entry_link_by(id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Document, {:params => params})
    end
        
  end

  class Document < SysObject
    def initialize(response)
      super(response)
    end

    def update(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      return navigate(link, 'post', :Document, {:post_body => attrs, :params => params})
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:delete])
      return navigate(link, 'delete', :Resource, {:params => params})
    end
  end

end