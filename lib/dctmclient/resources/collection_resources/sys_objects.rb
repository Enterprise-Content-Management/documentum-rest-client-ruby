module Dctmclient
  module Resources
    class SysObjects < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :SysObject, :query_params => query_params)
      end

      def create(properties)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :SysObject, :http_method => 'post', :post_body => properties)
      end
    end
  end
end