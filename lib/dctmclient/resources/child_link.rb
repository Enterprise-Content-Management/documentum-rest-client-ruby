module Dctmclient
  class ChildLinks < CollectionResource
    def initialize(response)
      super(response)
    end

    def create(sys_object, params = {})
      self_link = sys_object.find_link_by(Link::REL_NAMES[:edit])
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :ChildLink, {:post_body => {"href" => self_link.href}, :params => params})
    end
  end

  class ChildLink < SingleResource
    def initialize(response)
      super(response)
    end
  end

end