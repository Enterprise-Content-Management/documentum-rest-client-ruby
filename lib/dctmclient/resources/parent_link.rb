module Dctmclient
  class ParentLinks < CollectionResource
    def initialize(response)
      super(response)
    end

    def link(parent, params = {})
      parent_link = parent.find_link_by(Link::REL_NAMES[:self])
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :ParentLink, {:post_body => {"href" => parent_link["href"]}, :params => params})
    end

    def find(parent_folder_id, params = {})
      link = find_entry_link_by(parent_folder_id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :ParentLink, {:params => params})
    end

  end

  class ParentLink < SingleResource
    def initialize(response)
      super(response)
    end

    def move_link_to(another_parent, params = {})
      parent_link = another_parent.find_link_by(Link::REL_NAMES[:self])
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'put', :ParentLink, {:post_body => {"href" => parent_link["href"]}, :params => params})
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      return navigate(link, 'delete', :Resource, {:params => params})
    end
  end

end