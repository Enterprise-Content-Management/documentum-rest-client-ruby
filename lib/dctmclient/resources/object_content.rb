module Dctmclient
  class ObjectContents < CollectionResource
    def initialize(response)
      super(response)
    end

    def create(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :ObjectContent, {:post_body => attrs, :headers => {"Content-Type" => "plain/text"}, :params => params})
    end

    def find(format, modifier = nil, page = 0, params = {})
      id = "format=#{format}&modifier=#{modifier}&page=#{page}"
      link = find_entry_link_by(id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :ObjectContent, {:params => params})
    end

    private

    def find_entry_link_by(id, rel_name)
      return {} if @representation.nil? || @representation["entries"].nil?
      @representation["entries"].each do |entry|
        entry["links"].each do |link|
          return Link.new(link["rel"], link["href"]) if link["rel"] == rel_name && link["href"].end_with?(id)
        end
      end
      return {}
    end
  end

  class ObjectContent < SingleResource
    def initialize(response)
      super(response)
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'delete', :Resource, {:params => params})
    end
  end

end