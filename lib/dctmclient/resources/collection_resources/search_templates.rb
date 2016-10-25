module Dctmclient
  module Resources
    class SearchTemplates < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :SearchTemplate, :query_params => query_params)
      end

      def create(properties, query_doc_template)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :SearchTemplate, :http_method => 'post', :post_body => {'properties' => properties, 'query-document-template' => (query_doc_template).to_json.to_s})
      end
    end
  end
end