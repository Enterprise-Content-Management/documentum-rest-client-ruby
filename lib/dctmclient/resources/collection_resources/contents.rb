module Dctmclient
  module Resources
    class Contents < AbstractCollectionResource
      def create(content_type, body, query_params = {})
        link = find_link_by(Link::RELATIONS[:self])
        link_to(
            link,
            :Content,
            :http_method => 'post',
            :post_body => body,
            :http_headers => {"Content-Type" => content_type},
            :query_params => query_params
        )
      end
    end
  end
end