module Dctmclient
  class Folders < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(id, params = {})
      link = find_entry_link_by(id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Folder, {:params => params})
    end

    def create(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :Folder, {:post_body => attrs, :params => params})
    end
  end

  class Folder < Cabinet
    def initialize(response)
      super(response)
    end

    def update(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      return navigate(link, 'post', :Folder, {:post_body => attrs, :params => params})
    end

    def delete(del_non_empty = false, del_all_links = false, params = {})
      link = find_link_by(Link::REL_NAMES[:delete])
      params.store("del-non-empty", del_non_empty)
      params.store("del-all-links", del_all_links)
      return navigate(link, 'delete', :Resource, {:params => params})
    end

    def parent_links(params = {})
      link = find_link_by(Link::REL_NAMES[:parent_links])
      return navigate(link, 'get', :ParentLinks, {:params => params})
    end
    
  end
end
