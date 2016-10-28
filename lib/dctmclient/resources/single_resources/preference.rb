module Dctmclient
  module Resources
    class Preference < AbstractSingleResource
      def update(attrs)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :Preference, :http_method => 'post', :post_body => attrs)
      end

      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end
    end
  end
end