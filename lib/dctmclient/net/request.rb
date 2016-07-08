module Dctmclient

  # This class holds components for http request.
  # In fact, behind the APIs from all the resource(s) object, a Dctmclient::Requst object
  # would be built to execute the http request.
  class Request
    attr_accessor :url, :method, :headers, :post_body, :params

    MEDIA_TYPE = {:json => 'application/vnd.emc.documentum+json'}

    # Cache credential using class variable.
    @@credential = nil

    # Initialization
    #
    # ==== Attributes
    #
    # * +url+ - An absolute URL
    # * +method+ - one of ['get', 'post', 'put', 'delete']
    # * +options+ - A hash to config others, like headers, query parameters, post body
    #
    # ==== Examples
    #
    #  Request.new('http://localhost:8080/dctm-rest/services', 'get', {:headers => {"Accept" => 'json'}})
    #

    def initialize(url, method, options = {})
      @url, @method, @headers= url, method, {"Accept" => MEDIA_TYPE[:json], "Authorization" => @@credential}

      if option[:user_name] && option[:password]
        @@credential = basic_auth(option[:user_name], option[:password])
        @headers.store("Authorization", @@credential)
      end

      @headers.store("Content-Type", MEDIA_TYPE[:json]) if (@method == 'post' || @method == 'put') && !option[:upload_file]
      @headers.merge!(option[:headers]) if option[:headers]

      if option[:post_body]
        @post_body = option[:post_body]
        @post_body = option[:post_body].to_json if option[:post_body].is_a? Hash
      end

      @params = option[:params] if option[:params]
      append_params
    end

    # Send the http request, and return a Dctmclient::Response object.
    def execute
      response = nil
      begin
        response = if @method == 'get'
          RestClient.get(@url, @headers)
        elsif @method == 'post'
          RestClient.post(@url, @post_body, @headers)
        elsif @method == 'put'
          RestClient.put(@url, @post_body, @headers)
        elsif @method == 'delete'
          RestClient.delete(@url, @headers)
        else
          puts 'this method is not supported'
        end
      rescue RestClient::Exception => e
        return Response.new(e.http_code, e.http_body)
      end

      return Response.new(response.code, response.body, response.headers)
    end

    private

    def basic_auth(username, password)
      return "Basic " + Base64.encode64("#{username}:#{password}")
    end

    def append_params
      return nil if @url.nil? || @params.nil? || @params.empty?
      params = []
      @params.each { |k,v| params << "#{k}=#{v}"}
      existing_params = URI.split(@url)[7]
      @url = @url + (existing_params.nil? ? '?' : '&') + params.join('&')
    end

  end

end