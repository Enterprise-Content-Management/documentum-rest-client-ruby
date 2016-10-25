module Dctmclient
  module Resources
    class SavedSearches < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :SavedSearch, :query_params => query_params)
      end

      def create(properties, query_document)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :SavedSearch, :http_method => 'post', :post_body => {"properties" => properties, "query-document" => query_document})
      end
    end
  end
end