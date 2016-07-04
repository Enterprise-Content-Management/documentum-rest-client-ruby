module Dctmclient
  class RelationTypes < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(relation_type_name, params = {})
      link = find_entry_link_by(relation_type_name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :RelationType, {:params => params})
    end
  end

  class RelationType < SingleResource
    def initialize(response)
      super(response)
    end
  end

end