module Dctmclient
  module Resources
    class Documents < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :Document, :query_params => query_params)
      end
    end
  end
end