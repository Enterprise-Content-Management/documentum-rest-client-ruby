module Dctmclient
  class GroupUsers < CollectionResource
    def initialize(response)
      super(response)
    end

    # def add_a_user(user, params = {})
      # user_link = user.find_link_by(Link::REL_NAMES[:self])
      # link = find_link_by(Link::REL_NAMES[:self])
      # return navigate(link, 'post', :Resource, {:post_body => {"href" => user_link.href}, :params => params})
    # end
# 
    # def remove_a_user(username, params = {})
      # link = find_entry_link_by(Link::REL_NAMES[:delete])
      # return navigate(link, 'delete', :Resource, {:params => params})
    # end

  end

  class GroupUser < SingleResource
    def initialize(response)
      super(response)
    end

    # def delete(params = {})
      # link = find_link_by(Link::REL_NAMES[:delete])
      # return navigate(link, 'delete', :Resource, {:params => params})
    # end

  end

end