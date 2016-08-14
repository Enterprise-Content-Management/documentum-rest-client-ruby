module Dctmclient
  module Resources
    class Repositories < AbstractCollectionResource
      def find(name, user_name = nil, password = nil, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(
            link,
            :Repository,
            :http_headers => {:user_name => user_name, :password => password},
            :query_params => query_params
        )
      end
    end
  end
end