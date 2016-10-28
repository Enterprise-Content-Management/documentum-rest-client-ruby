module Dctmclient
  module Resources
    class Users < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :User, :query_params => query_params)
      end

      def create(properties)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :User, :http_method => 'post', :post_body => {'properties' => properties})
      end
    end
  end
end