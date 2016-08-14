module Dctmclient
  module Resources
    class ChildLinks < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(Link::RELATIONS[:edit])
        link_to(link, :ChildLink, :query_params => query_params)
      end
    end
  end
end