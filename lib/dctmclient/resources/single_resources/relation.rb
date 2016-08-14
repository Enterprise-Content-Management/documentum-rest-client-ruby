module Dctmclient
  module Resources
    class Relation < AbstractSingleResource
      def delete
        link = find_link_by(Link::RELATIONS[:self])
        link_to(link, :AbstractResource)
      end
    end
  end
end