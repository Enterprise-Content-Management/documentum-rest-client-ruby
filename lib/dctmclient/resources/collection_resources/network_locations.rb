module Dctmclient
  module Resources
    class NetworkLocations < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :NetworkLocation, :query_params => query_params)
      end
    end
  end
end