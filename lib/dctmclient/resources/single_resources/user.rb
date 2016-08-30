module Dctmclient
  module Resources
    class User < AbstractSingleResource
      def default_folder(query_params = {})
        link = find_link_by(Link::RELATIONS[:default_folder])
        link_to(link, :Cabinet, :query_params => query_params)
      end

      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :User, :http_method => 'post', :post_body => properties)
      end

      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end
    end
  end
end