module Dctmclient
  module Resources
    class Users < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :User, :query_params => query_params)
      end
    end
  end
end