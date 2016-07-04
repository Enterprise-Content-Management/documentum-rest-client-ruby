module Dctmclient
  class SubGroups< CollectionResource
    def initialize(response)
      super(response)
    end

    # def add_a_sub_group(group, params = {})
      # group_link = group.find_link_by(Link::REL_NAMES[:self])
      # link = find_link_by(Link::REL_NAMES[:self])
      # return navigate(link, 'post', :Resource, {:post_body => {"href" => group_link.href}, :params => params})
    # end
# 
    # def remove_a_sub_group(groupname, params = {})
      # link = find_entry_link_by(groupname, Link::REL_NAMES[:delete])
      # return navigate(link, 'delete', :Resource, {:params => params})
    # end
  end

end