module Dctmclient
  module Resources
    class ParentLinks < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :ParentLink, :query_params => query_params)
      end
    end
  end
end