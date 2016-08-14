module Dctmclient
  module Resources
    class AbstractResource
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def representation_json
        JSON.parse(@response.body)
      end

      def find_link_by(relation_name)
        return nil if representation_json.nil? || representation_json['links'].nil?

        raw_target_link = representation_json['links'].select { |link| link['rel'] == relation_name }.first
        return nil if raw_target_link.nil?

        href = raw_target_link['hreftemplate'] ? raw_target_link['hreftemplate'] : raw_target_link['href']
        Link.new(relation_name, href)
      end

      def link_to(link, resource_class, options = {})
        raise Dctmclient::Exception::LinkNotFoundException, "link not found for #{resource_class}" if link.nil?

        http_method, query_params = options[:http_method], options[:query_params]
        http_headers, post_body = options[:http_headers], options[:post_body]

        response = Dctmclient::Net::Request.new(link.href, http_method, query_params, http_headers, post_body).execute
        Dctmclient::Resources.const_get(resource_class).new(response)
      end

      def inspect
        @response.inspect
      end

      def to_s
        @response.to_s
      end

      private

      def validate_response
        raise Dctmclient::Exception::DctmclientRequestException, @response.http_status_code if !request_success?
      end

      def request_success?
        @response && [200, 201, 204].include?(@response.http_status_code)
      end

    end
  end
end


