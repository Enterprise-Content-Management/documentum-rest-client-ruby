module Dctmclient
  module Resources
    class Preferences < AbstractCollectionResource
      def find(client_code, query_params = {})
        link = find_entry_link_by(client_code, Link::RELATIONS[:edit])
        link_to(link, :Preference, :query_params => query_params)
      end

      def create(preference)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :Preference, :http_method => 'post', :post_body => preference)
      end
    end
  end
end