module Dctmclient
  module Resources
    class SavedSearch < AbstractSingleResource
      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      def update(properties, query_document)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :SavedSearch, :http_method => 'post', :post_body => {'properties' => properties, 'query-document' => query_document})
      end

      def execute(query_params = {})
        link = find_link_by(:search_execution)
        link_to(link, :AbstractCollectionResource, :query_params => query_params)
      end


      # saved search

      def saved_results(query_params = {})
        link = find_link_by(Link::RELATIONS[:saved_search_results])
        link_to(link, :AbstractCollectionResource, :query_params => query_params)
      end

      def refresh_results(query_params = {})
        link = find_link_by(Link::RELATIONS[:saved_search_results])
        link_to(link, :AbstractCollectionResource, :http_method => 'put', :query_params => query_params)
      end

      def disable_results
        link = find_link_by(Link::RELATIONS[:saved_search_results])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end
    end
  end
end