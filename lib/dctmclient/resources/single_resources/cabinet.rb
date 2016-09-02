module Dctmclient
  module Resources
    class Cabinet < AbstractSingleResource
      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :Cabinet, :http_method => 'post', :post_body => properties)
      end

      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete', :query_params => {'del-non-empty' => true, 'del-all-links' => true})
      end

      def sub_folders(query_params = {})
        link = find_link_by(Link::RELATIONS[:folders])
        link_to(link, :Folders, :query_params => query_params)
      end

      def documents(query_params = {})
        link = find_link_by(Link::RELATIONS[:documents])
        link_to(link, :Documents, :query_params => query_params)
      end

      def sys_objects(query_params = {})
        link = find_link_by(Link::RELATIONS[:sys_objects])
        link_to(link, :SysObjects, :query_params => query_params)
      end

      def child_links(query_params = {})
        link = find_link_by(Link::RELATIONS[:child_links])
        link_to(link, :ChildLinks, :query_params => query_params)
      end

      def create_sys_object(properties, type = 'dm_document')
        properties['properties'].store('r_object_type', type)
        link = find_link_by(Link::RELATIONS[:sys_objects])
        link_to(link, :SysObject, :http_method => 'post', :post_body => properties)
      end

      def create_document_without_content(properties)
        link = find_link_by(Link::RELATIONS[:documents])
        link_to(link, :Document, :http_method => 'post', :post_body => properties)
      end

      def create_document_with_primary_content(name, primary_content, format = 'unknown')
        link = find_link_by(Link::RELATIONS[:documents])
        post_body = "--1024\r\nContent-Disposition: form-data; name=metadata\r\nContent-Type: application/vnd.emc.documentum+json\r\n\r\n{\"properties\":{\"object_name\":\"#{name}\"}}\r\n--1024\r\nContent-Disposition: form-data;name=content\r\nContent-Type: text/plain\r\n\r\n#{primary_content}\r\n--1024--\r\n"
        link_to(link, :Document, :http_method => 'post', :post_body => post_body, :http_headers => {"Content-Type" => "multipart/form-data;boundary=1024"}, :query_params => {'format' => format})
      end

      def copy_sys_object_from(href, deep_copy = true)
        link = find_link_by(Link::RELATIONS[:sys_objects])
        link_to(link, :SysObject, :http_method => 'post', :post_body => {"href" => href, "deep-copy" => deep_copy})
      end

      def makes_a_link_from(sys_object)
        link = find_link_by(Link::RELATIONS[:child_links])
        link_to(link, :ChildLink, :http_method => 'post', :post_body => {"href" => sys_object.id})
      end

    end
  end
end