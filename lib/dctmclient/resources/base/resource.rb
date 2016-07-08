module Dctmclient
  # In this program, we define many resources responding to REST Services's. This class is
  # the topmost class inherited by other concrete resources.
  # All the resources objects are initialized by a Response object. If the status code in the response
  # object is not within [200, 201, 204], a RequestException would be raised in the process of initializtion.

  class Resource
    # Represents a Response object
    attr_accessor :response

    # Represents the response body in JSON
    attr_accessor :representation

    def initialize(response)
      @response, @representation = response, nil

      validate

      begin
        @representation = JSON.parse(response.body) if response.body && !response.body.empty?
      rescue JSON::ParserError => e
        @representation = {:response_body => response.body}
      end
    end

    # Navigate to other resource(s) given a resouce object
    #
    # ==== Attributes
    # * +link+ - a Dctmclient::Link object
    # * +http_method+ - Http verbs, ['get', 'post', 'delete', 'put']
    # * +response_class+ - All the resouce(s) Object class
    # * +options+ - A hash
    #
    # ==== Options
    # You may set options to config the HTTP request by below three parts.
    #
    # * +:headers+ - setting http request headers
    # * +:post_body+ - setting post body for POST or PUT
    # * +:params+  -setting query parameters
    def navigate(link, http_method, response_class, options = {})
      raise NavigationException.new("#{link.href} doesn't exist!") if link.empty?
      response = Request.new(link.href, http_method, option).execute
      return Dctmclient.const_get(response_class).new(response)
    end

    # Return a Dctmcclient::Link object via searching rel_name in the representation.
    #
    # ==== Attributes
    #
    # * +rel_name+ - Dctmclient::Link::REL_NAMES
    def find_link_by(rel_name)
      return {} if @representation.nil? || @representation["links"].nil?
      links = @representation["links"].select { |link| link["rel"] == rel_name }
      return {} if links.nil? || links.empty?
      link = links.first
      href = (link['hreftemplate'] ? link['hreftemplate'] : link['href'])
      return Link.new(link['rel'], href)
    end

    # Construct a response in hash
    def raw_response_from_rest_services
      return {:code => @response.code, :body => @response.body, :headers => @response.headers}
    end

    def representation
      return @representation
    end

    def validate
      raise RequestException.new(@response.code) unless [200, 201, 204].include?(@response.code)
    end
  end

  # This class represents the topmost class for collection resources.
  class CollectionResource < Resource
    def initialize(response)
      super(response)
    end

    def first_page
      link = find_link_by(Link::REL_NAMES[:first])
      navigate(link, 'get', self.class.to_s)
    end


    def last_page
      link = find_link_by(Link::REL_NAMES[:last])
      navigate(link, 'get', self.class.to_s)
    end

    def previous_page
      link = find_link_by(Link::REL_NAMES[:previous])
      navigate(link, 'get', self.class.to_s)
    end

    def next_page
      link = find_link_by(Link::REL_NAMES[:next])
      navigate(link, 'get', self.class.to_s)
    end

    # Search a link by comparing id and relation name, and a Dctmclient::Link object is returned.
    #
    # ==== Attributes
    #
    # * +id+ - a resouce object id
    # * +rel_name+ - Dctmclient::Link::REL_NAMES
    #
    def find_entry_link_by(id, rel_name)
      return {} if @representation.nil? || @representation["entries"].nil?
      entries = @representation["entries"].select { |entry| entry["id"].end_with?(id) }
      return {} if entries.nil? || entries.empty?
      links = entries.first["links"].select { |link| link["rel"] == rel_name }
      return {} if links.nil?

      link = links.first
      rel_name = link['rel']
      href = link['href']
      return Link.new(rel_name, href)
    end

  end

  # This class reprents the topmost single resource.
  class SingleResource < Resource
    def initialize(response)
      super(response)
    end
  end
end