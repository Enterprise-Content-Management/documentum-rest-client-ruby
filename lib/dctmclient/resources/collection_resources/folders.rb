module Dctmclient
  module Resources
    class Folders < AbstractCollectionResource
      def find(id, query_params = {})
        link = find_entry_link_by(id, Link::RELATIONS[:edit])
        link_to(link, :Folder, :query_params => query_params)
      end

      def create_sub_folder(properties)
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :Folder, :http_method => 'post', :post_body => properties)
      end
    end
  end
end