module Dctmclient

  class Resource
    attr_accessor :response, :representation
    def initialize(response)
      @response, @representation = response, nil

      validate

      begin
        @representation = JSON.parse(response.body) if response.body && !response.body.empty?
      rescue JSON::ParserError => e
        @representation = {:response_body => response.body }
      end
    end

#  
    def navigate(link, http_method, response_class, option = {})
      raise NavigationException.new("#{link.href} doesn't exist!") if link.empty?
      response = Request.new(link.href, http_method, option).execute
      return Dctmclient.const_get(response_class).new(response)
    end


    def find_link_by(rel_name)
      return {} if @representation.nil? || @representation["links"].nil?
      links = @representation["links"].select { |link| link["rel"] == rel_name }
      return {} if links.nil? || links.empty?
      link = links.first
      href = (link['hreftemplate'] ? link['hreftemplate'] : link['href'])
      return Link.new(link['rel'], href)
    end

    def raw_response_from_rest_services
      return { :code => @response.code, :body => @response.body, :headers => @response.headers }
    end

    def representation
      return @representation
    end

    def validate
      raise RequestException.new(@response.code) unless [200, 201, 204].include?(@response.code)
    end
  end


  class CollectionResource < Resource
    def initialize(response)
      super(response)
    end

    def first_page
      link  = find_link_by(Link::REL_NAMES[:first])
      navigate(link, 'get', self.class.to_s)
    end


    def last_page
      link  = find_link_by(Link::REL_NAMES[:last])
      navigate(link, 'get', self.class.to_s)
    end

    def previous_page
      link  = find_link_by(Link::REL_NAMES[:previous])
      navigate(link, 'get', self.class.to_s)
    end

    def next_page
      link  = find_link_by(Link::REL_NAMES[:next])
      navigate(link, 'get', self.class.to_s)
    end


    def find_entry_link_by(id, rel_name)
      return {} if @representation.nil? || @representation["entries"].nil?
      entries = @representation["entries"].select {|entry| entry["id"].end_with?(id)}
      return {} if entries.nil? || entries.empty?
      links = entries.first["links"].select {|link| link["rel"] == rel_name}
      return {} if links.nil?

      link = links.first
      rel_name = link['rel']
      href = link['href']
      return Link.new(rel_name, href)
    end

  end

  class SingleResource < Resource
    def initialize(response)
      super(response)
    end
  end
end