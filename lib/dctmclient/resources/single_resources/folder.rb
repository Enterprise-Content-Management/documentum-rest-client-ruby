require_relative File.dirname(__FILE__) + '/cabinet'

module Dctmclient
  module Resources
    class Folder < Cabinet
      def parent_links(query_params = {})
        link = find_link_by(Link::RELATIONS[:parent_links])
        link_to(link, :ParentLinks, :query_params => query_params)
      end

      def cabinet(query_params = {})
        link = find_link_by(Link::RELATIONS[:cabinet])
        link_to(link, :Cabinet, :query_params => query_params)
      end

      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :Folder, :http_method => 'post', :post_body => properties)
      end
    end
  end
end