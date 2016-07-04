module Dctmclient
  class Repositories < CollectionResource
    def initialize(response)
      super(response)
    end

    def find(repo_name, user_name, password, params = {})
      link = find_entry_link_by(repo_name, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :Repository, {:params => params, :user_name => user_name, :password => password})
    end
  end

  class Repository < SingleResource
    def initialize(response)
      super(response)
    end

    def users(params = {})
      link = find_link_by(Link::REL_NAMES[:users])
      return navigate(link, 'get', :Users, {:params => params})
    end

    def groups(params = {})
      link = find_link_by(Link::REL_NAMES[:groups])
      return navigate(link, 'get', :Groups, {:params => params})
    end

    def cabinets(params = {})
      link = find_link_by(Link::REL_NAMES[:cabinets])
      return navigate(link, 'get', :Cabinets, {:params => params})
    end

    def network_locations(params = {})
      link = find_link_by(Link::REL_NAMES[:network_locations])
      return navigate(link, 'get', :NetworkLocations, {:params => params})
    end

    def formats(params = {})
      link = find_link_by(Link::REL_NAMES[:formats])
      return navigate(link, 'get', :Formats, {:params => params})
    end

    def query_by(dql, params = {})
      link = find_link_by(Link::REL_NAMES[:dql])
      link.href.sub!('{?dql}', "?dql=#{dql}")
      return navigate(link, 'get', :CollectionResource, {:params => params})
    end

    def current_user(params = {})
      link = find_link_by(Link::REL_NAMES[:current_user])
      return navigate(link, 'get', :User, {:params => params})
    end

    def types(params = {})
      link = find_link_by(Link::REL_NAMES[:types])
      return navigate(link, 'get', :Types, {:params => params})
    end

    def relation_types(params = {})
      link = find_link_by(Link::REL_NAMES[:relation_types])
      return navigate(link, 'get', :RelationTypes, {:params => params})
    end

    def relations(params = {})
      link = find_link_by(Link::REL_NAMES[:relations])
      return navigate(link, 'get', :Relations, {:params => params})
    end

    def search_by_query_params(params = {})
      link = find_link_by(Link::REL_NAMES[:search])
      link.href.sub!(/{.*}/, '')
      return navigate(link, 'get', :CollectionResource, {:params => params})
    end

    def checked_out_objects(params = {})
      link = find_link_by(Link::REL_NAMES[:checked_out_objects])
      return navigate(link, 'get', :SysObjects, {:params => params})
    end

    def execute_batch(config, options, params = {})
      link = find_link_by(Link::REL_NAMES[:batches])
      post_body = config.merge({"operations" => options})
      return navigate(link, 'post', :CollectionResource, {:post_body => post_body, :params => params})
    end

    def batch_capabilities(params = {})
      link = find_link_by(Link::REL_NAMES[:batch_capabilities])
      return navigate(link, 'get', :BatchCapabilities, {:params => params})
    end

  end

end