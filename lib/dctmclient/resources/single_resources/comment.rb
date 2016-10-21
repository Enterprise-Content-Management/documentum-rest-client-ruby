module Dctmclient
  module Resources
    class Comment < AbstractSingleResource
      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      def replies(query_params = {})
        link = find_link_by(Link::RELATIONS[:replies])
        link_to(link, :Comments, :query_params => query_params)
      end
    end
  end
end