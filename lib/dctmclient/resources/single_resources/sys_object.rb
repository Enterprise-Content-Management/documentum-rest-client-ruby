module Dctmclient
  module Resources
    class SysObject < AbstractSingleResource
      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :SysObject, :http_method => 'post', :post_body => properties)
      end

      def delete
        link = find_link_by(Link::RELATIONS[:delete])
        link_to(link, :AbstractResource, :http_method => 'delete', :query_params => {'del-non-empty' => true, 'del-all-links' => true, 'del-version' => 'all'})
      end

      def contents(query_params = {})
        link = find_link_by(Link::RELATIONS[:contents])
        link_to(link, :Contents, :query_params => query_params)
      end

      def versions(query_params = {})
        link = find_link_by(Link::RELATIONS[:versions])
        link_to(link, :Versions, :query_params => query_params)
      end

      def current_version(query_params = {})
        link = find_link_by(Link::RELATIONS[:current_version])
        link_to(link, :Version, :query_params => query_params)
      end

      def check_out
        return self if checked_out?
        link = find_link_by(Link::RELATIONS[:check_out])
        return link_to(link, :SysObject, :http_method => 'put')
      end

      def cancel_check_out
        return self if !checked_out?
        link = find_link_by(Link::RELATIONS[:cancel_check_out])
        return link_to(link, :AbstractResource, :http_method => 'delete')
      end

      def check_in_next_major(binary_content)
        check_in(binary_content, :check_in_next_major)
      end

      def check_in_next_minor(binary_content)
        check_in(binary_content, :check_in_next_minor)
      end

      def check_in_branch_version(binary_content)
        check_in(binary_content, :check_in_branch_version)
      end

      def parent_links(query_params = {})
        link = find_link_by(Link::RELATIONS[:parent_links])
        link_to(link, :ParentLinks, :query_params => query_params)
      end

      def linking_to(another_folder)
        link = find_link_by(Link::RELATIONS[:parent_links])
        link_to(link, :ParentLink, :http_method => 'post', :post_body => {"href" => another_folder.find_link_by(Link::RELATIONS[:edit]).href})
      end

      def move(src_folder, dst_folder, include_all_versions = true)
        link = find_link_by(Link::RELATIONS[:parent_links])
        link.href += "/#{src_folder.id}"
        link_to(link, :ParentLink, :http_method => 'put', :post_body => {'href' => dst_folder.find_link_by(Link::RELATIONS[:edit]).href}, :query_params => {"include-all-versions" => include_all_versions})
      end

      def unlink_from(folder)
        link = find_link_by(Link::RELATIONS[:parent_links])
        link.href += "/#{folder.id}"
        link_to(link, :AbstractResource, :http_method => 'delete')
      end

      def checked_out?
        return find_link_by(Link::RELATIONS[:check_out]).nil?
      end

      def comments(query_params = {})
        link = find_link_by(Link::RELATIONS[:comments])
        link_to(link, :Comments, :query_params => query_params)
      end


      private

      # Set Content-Type to avoid using default value(json), which blocks file uploading.
      def check_in(binary_content, version_policy)
        return self if !checked_out?
        link = find_link_by(Link::RELATIONS[version_policy])
        link_to(link, :SysObject, :http_method => 'post', :post_body => binary_content, :http_headers => {'Content-Type' => ''})
      end
    end
  end
end