module Dctmclient
  module Resources
    class Repository < AbstractSingleResource
      def users(query_params = {})
        link = find_link_by(Link::RELATIONS[:users])
        link_to(link, :Users, :query_params => query_params)
      end

      def groups(query_params = {})
        link = find_link_by(Link::RELATIONS[:groups])
        link_to(link, :Groups, :query_params => query_params)
      end

      def cabinets(query_params = {})
        link = find_link_by(Link::RELATIONS[:cabinets])
        link_to(link, :Cabinets, :query_params => query_params)
      end

      def network_locations(query_params = {})
        link = find_link_by(Link::RELATIONS[:network_locations])
        link_to(link, :NetworkLocations, :query_params => query_params)
      end

      def formats(query_params = {})
        link = find_link_by(Link::RELATIONS[:formats])
        link_to(link, :Formats, :query_params => query_params)
      end

      def types(query_params = {})
        link = find_link_by(Link::RELATIONS[:types])
        link_to(link, :Types, :query_params => query_params)
      end

      def relation_types(query_params = {})
        link = find_link_by(Link::RELATIONS[:relation_types])
        link_to(link, :RelationTypes, :query_params => query_params)
      end

      def relations(query_params = {})
        link = find_link_by(Link::RELATIONS[:relations])
        link_to(link, :Relations, :query_params => query_params)
      end

      def query(dql, query_params = {})
        link = find_link_by(Link::RELATIONS[:dql])
        link.href.sub!('{?dql}', "?dql=#{dql}")
        link_to(link, :AbstractCollectionResource, :query_params => query_params)
      end

      def search(query_params = {})
        link = find_link_by(Link::RELATIONS[:search])
        link.href.sub!(/{.*}/, '')
        link_to(link, :AbstractCollectionResource, :query_params => query_params)
      end

      def batch_capabilities(query_params = {})
        link = find_link_by(Link::RELATIONS[:batch_capabilities])
        link_to(link, :BatchCapabilities, :query_params => query_params)
      end

      def current_user(query_params = {})
        link = find_link_by(Link::RELATIONS[:current_user])
        link_to(link, :User, :query_params => query_params)
      end

      def checked_out_objects(query_params = {})
        link = find_link_by(Link::RELATIONS[:checked_out_objects])
        link_to(link, :CheckedOutObjects, :query_params => query_params)
      end


      def execute_batch(config, operations)
        link = find_link_by(Link::RELATIONS[:batches])
        post_body = {}
        post_body.merge!(config).merge!("operations" => operations)
        link_to(link, :AbstractCollectionResource, :http_method => 'post', :post_body => post_body)
      end
    end
  end
end