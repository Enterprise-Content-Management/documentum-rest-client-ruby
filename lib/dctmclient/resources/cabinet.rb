module Dctmclient
  class Cabinets < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(id, params = {})
      link = find_entry_link_by(id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Cabinet, {:params => params})
    end

    def create(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :Cabinet, {:post_body => attrs, :params => params})
    end

  end

  class Cabinet < SingleResource
    def initialize(response)
      super(response)
    end

    def update(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      return navigate(link, 'post', :Cabinet, {:post_body => attrs, :params => params})
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:delete])
      return navigate(link, 'delete', :Resource, {:params => params})
    end

    def sub_folders(params = {})
      link = find_link_by(Link::REL_NAMES[:folders])
      return navigate(link, 'get', :Folders, {:params => params})
    end

    def documents(params = {})
      link = find_link_by(Link::REL_NAMES[:documents])
      return navigate(link, 'get', :Documents, {:params => params})
    end

    def sys_objects(params = {})
      link = find_link_by(Link::REL_NAMES[:objects])
      return navigate(link, 'get', :SysObjects, {:params => params})
    end

    def relations(params = {})
      link = find_link_by(Link::REL_NAMES[:relations])
      return navigate(link, 'get', :Relations, {:params => params})
    end

    def child_links(params = {})
      link = find_link_by(Link::REL_NAMES[:child_links])
      return navigate(link, 'get', :ChildLinks, {:params => params})
    end
   
  end

end