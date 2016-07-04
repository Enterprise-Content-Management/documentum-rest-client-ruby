module Dctmclient
  class Users < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(name, params = {})
      link = find_entry_link_by(name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :User, {:params => params})
    end

    # def create(attrs, params = {})
      # link = find_link_by(Link::REL_NAMES[:self])
      # return navigate(link, 'post', :User, {:post_body => attrs, :params => params})
    # end
  end

  class User < SingleResource
    def initialize(response)
      super(response)
    end

    # def update(attrs, params = {})
      # link = find_link_by(Link::REL_NAMES[:edit])
      # return navigate(link, 'post', :User, {:post_body => attrs, :params => params})
    # end
# 
    # def delete(params = {})
      # link = find_link_by(Link::REL_NAMES[:delete])
      # return navigate(link, 'delete', :Resource, {:params => params})
    # end

    def default_folder(params = {})
      link = find_link_by(Link::REL_NAMES[:user_default_folder])
      return navigate(link, 'get', :Folder, {:params => params})
    end

  end

end