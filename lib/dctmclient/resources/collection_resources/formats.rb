module Dctmclient
  module Resources
    class Formats < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :Format, :query_params => query_params)
      end
    end
  end
end