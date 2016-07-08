module Dctmclient
  class SysObjects < CollectionResource
    def initialize(response)
      super(response)
    end

    def create(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :SysObject, {:post_body => attrs, :params => params})
    end

    def create_document(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:self])
      return navigate(link, 'post', :Document, {:post_body => attrs, :params => params})
    end

    def find(sys_object_id, params = {})
      link = find_entry_link_by(sys_object_id, Link::REL_NAMES[:edit])
      return navigate(link, 'get', :SysObject, {:params => params})
    end

  end

  class SysObject < SingleResource
    def initialize(response)
      super(response)
    end

    def update(attrs, params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      return navigate(link, 'post', :SysObject, {:post_body => attrs, :params => params})
    end

    def delete(params = {})
      link = find_link_by(Link::REL_NAMES[:delete])
      return navigate(link, 'delete', :Resource, {:params => params})
    end

    def parent_links(params = {})
      link = find_link_by(Link::REL_NAMES[:parent_links])
      return navigate(link, 'get', :ParentLinks, {:params => params})
    end

    def cabinet(params = {})
      link = find_link_by(Link::REL_NAMES[:cabinet])
      return navigate(link, 'get', :Cabinet, {:params => params})
    end

    def contents(params = {})
      link = find_link_by(Link::REL_NAMES[:contents])
      return navigate(link, 'get', :ObjectContents, {:params => params})
    end

    def content_media(format, page, modifier, params = {})
      link = find_link_by(Link::REL_NAMES[:edit])
      link.href = link.href + "/content-media?page=#{page}&format=#{format}&modifier=#{modifier}"
      return navigate(link, 'get', :ContentMedia, {:params => params})
    end

    def primary_content(params = {})
      link = find_link_by(Link::REL_NAMES[:primary_content])
      return navigate(link, 'get', :ObjectContent, {:params => params})
    end

    def checkout(params = {})
      return self if checked_out?
      link = find_link_by(Link::REL_NAMES[:checkout])
      return navigate(link, 'put', :SysObject, {:params => params})
    end

    def cancel_checkout(params = {})
      return self if !checked_out?
      link = find_link_by(Link::REL_NAMES[:cancel_checkout])
      return navigate(link, 'delete', :Resource, {:params => params})
    end

    def checkin_next_major(file_content, params = {})
      return self if !checked_out?
      link = find_link_by(Link::REL_NAMES[:checkin_next_major])
      return navigate(link, 'post', :SysObject, {:post_body => file_content, :params => params, :upload_file => true})
    end

    def checkin_next_minor(file_content, params = {})
      return self if !checked_out?
      link = find_link_by(Link::REL_NAMES[:checkin_next_minor])
      return navigate(link, 'post', :SysObject, {:post_body => file_content, :params => params, :upload_file => true})
    end

    def versions(params = {})
      link = find_link_by(Link::REL_NAMES[:version_history])
      return navigate(link, 'get', :Versions, {:params => params})
    end

    def current_version(params = {})
      link = find_link_by(Link::REL_NAMES[:current_version])
      return navigate(link, 'get', :SysObject, {:params => params})
    end

    def predecessor_version(params = {})
      link = find_link_by(Link::REL_NAMES[:predecessor_version])
      return navigate(link, 'get', :SysObject, {:params => params})
    end

    private

    def checked_out?
      link = find_link_by(Link::REL_NAMES[:checkout])
      return link.empty?
    end
  end

end