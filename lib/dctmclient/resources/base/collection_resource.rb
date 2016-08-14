module Dctmclient
  module Resources
    class AbstractCollectionResource < AbstractResource
      def find_entry_link_by(id, relation)
        return nil if representation_json.nil?

        target_entry = representation_json['entries'].select { |entry| entry['id'].end_with?(id) }.first
        return nil if target_entry.nil? || target_entry['links'].nil?

        target_link = target_entry['links'].select { |link| link['rel'] == relation }.first
        return nil if target_link.nil?

        href = target_link['hreftemplate'] ? target_link['hreftemplate'] : target_link['href']
        Link.new(relation, href)
      end

      # This method enables collection resource to paginate. If query parameters *items-per-page* and *page* are
      # specified again in the *query_params*, it would not take effect.
      # Meanwhile, prior to call this method, checking whether the current page resource instance has the corresponding
      # pagination link or not should be invoked, which can be done by these methods, whose names are in the pattern of
      # "has_<paginatin_link>_link?". Otherwise, LinkNotFoundException would be raised in the runtime if pagination link
      # was not found.
      # @param pagination_link symbol, specifies the navigation direction, valid values are [:first, :next, :last, :previous]
      def navigate(pagination_link, query_params = {})
        link = find_link_by(Link::RELATIONS[pagination_link])
        link_to(link, self.method(:navigate).receiver.class.to_s, :query_params => query_params)
      end

      def has_first_link?
        !find_link_by(Link::RELATIONS[:first]).nil?
      end

      def has_next_link?
        !find_link_by(Link::RELATIONS[:next]).nil?
      end

      def has_last_link?
        !find_link_by(Link::RELATIONS[:last]).nil?
      end

      def has_previous_link?
        !find_link_by(Link::RELATIONS[:previous]).nil?
      end

    end
  end
end
