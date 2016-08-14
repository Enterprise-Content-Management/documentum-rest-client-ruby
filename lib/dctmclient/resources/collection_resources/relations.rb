module Dctmclient
  module Resources
    class Relations < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :Relation, :query_params => query_params)
      end

      def create(properties)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :Relation, :http_method => 'post', :post_body => properties)
      end
    end
  end
end