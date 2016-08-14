module Dctmclient
  module Resources
    class RelationTypes < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :RelationType, :query_params => query_params)
      end
    end
  end
end