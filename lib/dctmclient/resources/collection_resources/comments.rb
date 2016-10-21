module Dctmclient
  module Resources
    class Comments < AbstractCollectionResource
      def find(id, query_params = {})
        link =find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :Comment, :query_params => query_params)
      end

      def create(content_value)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :Comment, :http_method => 'post', :post_body => {'content-value' => content_value})
      end
    end
  end
end