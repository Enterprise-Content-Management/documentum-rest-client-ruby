module Dctmclient
  module Resources
    class Group < AbstractSingleResource
      def sub_groups(query_params = {})
        link = find_link_by(Link::RELATIONS[:groups])
        link_to(link, :Groups, :query_params => query_params)
      end

      def users(query_params = {})
        link = find_link_by(Link::RELATIONS[:users])
        link_to(link, :Users, :query_params => query_params)
      end
    end
  end
end