module Dctmclient
  module Resources
    class SearchTemplate < AbstractSingleResource
      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      def execute(external_variables)
        link = find_link_by(Link::RELATIONS[:search_execution])
        link_to(link, :AbstractCollectionResource, :http_method => 'post', :post_body => {'external-variables' => external_variables})
      end
    end
  end
end