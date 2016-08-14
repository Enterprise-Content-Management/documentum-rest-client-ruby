module Dctmclient
  module Resources
    class User < AbstractSingleResource
      def default_folder(query_params = {})
        link = find_link_by(Link::RELATIONS[:default_folder])
        link_to(link, :Cabinet, :query_params => query_params)
      end
    end
  end
end