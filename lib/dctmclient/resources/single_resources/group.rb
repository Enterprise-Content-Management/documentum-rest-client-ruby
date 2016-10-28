module Dctmclient
  module Resources
    class Group < AbstractSingleResource
      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :Group, :http_method => 'post', :post_body => {'properties' => properties})
      end

      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      # operations for sub group

      def sub_groups(query_params = {})
        link = find_link_by(Link::RELATIONS[:groups])
        link_to(link, :Groups, :query_params => query_params)
      end

      def add_member_group(name)
        link = find_link_by(Link::RELATIONS[:groups])
        href = link.href.sub(/groups\/.*/, "groups/#{name}")
        link_to(link, :AbstractResource, :http_method => 'post', :post_body => {'href' => href})
      end

      def remove_member_group(name)
        link = find_link_by(Link::RELATIONS[:groups])
        link.href += "/#{name}"
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      # operations for group user

      def users(query_params = {})
        link = find_link_by(Link::RELATIONS[:users])
        link_to(link, :Users, :query_params => query_params)
      end

      def add_member_user(name)
        link = find_link_by(Link::RELATIONS[:users])
        href = link.href.sub(/groups\/.*/, "users/#{name}")
        link_to(link, :AbstractResource, :http_method => 'post', :post_body => {'href' => href})
      end

      def remove_member_user(name)
        link = find_link_by(Link::RELATIONS[:users])
        link.href += "/#{name}"
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

    end
  end
end