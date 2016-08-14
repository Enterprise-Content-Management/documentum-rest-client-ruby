require 'rest-client'
require 'base64'
require 'awesome_print'
require 'yaml'

require_relative File.dirname(__FILE__) + '/response'

module Dctmclient
  module Net

    MEDIA_TYPES = {
        :json => 'application/vnd.emc.documentum+json'
    }

    class Request
      attr_accessor :url, :http_method, :query_params, :http_headers, :post_body

      @@credential = nil

      def initialize(url, http_method, query_params = {}, http_headers = {}, post_body = {})
        @url = url
        @http_method = http_method
        @query_params = query_params
        @http_headers = http_headers
        @post_body = post_body
      end

      def execute
        build_request
        ap @url
        # ap @http_method
        # ap @http_headers

        begin
          response = case @http_method
                       when 'get'
                         RestClient.get(@url, @http_headers)
                       when 'post'
                         RestClient.post(@url, @post_body, @http_headers)
                       when 'put'
                         RestClient.put(@url, @post_body, @http_headers)
                       when 'delete'
                         RestClient.delete(@url, @http_headers)
                       else
                         puts 'method not supported'
                         nil
                     end
        rescue RestClient::Exception => e
          return Dctmclient::Net::Response.new(e.http_code, e.http_body)
        end

        Dctmclient::Net::Response.new(response.code, response.body, response.headers)
      end

      private


      def build_request
        @url += build_query_params
        @url = URI.encode(@url) if !not_need_encode?

        @http_method ||= 'get'
        @http_headers ||= {}

        @http_headers.store("Accept", MEDIA_TYPES[:json]) if @http_headers['Accept'].nil?

        if @http_headers.has_key?(:user_name)
          encoded_credential = basic_auth(@http_headers[:user_name], @http_headers[:password])
          @http_headers.store("Authorization", encoded_credential)
          @@credential = encoded_credential
        else
          @http_headers.store("Authorization", @@credential)
        end


        # if need_authentication? && @http_headers["Authorization"].nil?
        #   @http_headers.store("Authorization", basic_auth(credential['repository']['user_name'], credential['repository']['password']))
        #   # @http_headers.store("Authorization", basic_auth("Administrator", "password"))
        # end

        if @http_headers['Content-Type'].nil? && ['put', 'post'].include?(@http_method)
          @http_headers.store('Content-Type', MEDIA_TYPES[:json])
        end

        @post_body = @post_body.to_json if @post_body.is_a? Hash
      end

      def basic_auth(username, password)
        format('Basic %s', Base64.encode64("#{username}:#{password}"))
      end

      def build_query_params
        return '' if @query_params.nil? || @query_params.empty?

        query_params = []
        @query_params.each { |name, value| query_params << "#{name}=#{value}" }

        existing_query_params = URI.split(URI.encode @url)[7]
        (existing_query_params ? '&' : '?') + query_params.join('&')
      end

      def need_authentication?
        @url.split('/repositories/').size == 2
      end

      # Avoid changing the URL by encoding if original has special character, like following:
      # http://localhost:8080/repositories/REPO/relation-types/ACL%2BREPLICATION
      # It would be encoded to
      # http://localhost:8080/repositories/REPO/relation-types/ACL%252BREPLICATION
      def not_need_encode?
        return @url.include?('/relation-types/')
      end

    end


  end
end