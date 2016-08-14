module Dctmclient
  module Resources
    class Cabinets < AbstractCollectionResource
      def find(name, query_params = {})
        link = find_entry_link_by(name, Link::RELATIONS[:edit])
        link_to(link, :Cabinet, :query_params => query_params)
      end

      def create(properties)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :Cabinet, :http_method => 'post', :post_body => properties)
      end
    end
  end
end