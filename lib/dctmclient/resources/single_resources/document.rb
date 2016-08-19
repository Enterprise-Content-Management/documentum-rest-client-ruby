require_relative File.dirname(__FILE__) + '/sys_object'

module Dctmclient
  module Resources
    class Document < SysObject
      def update(properties)
        link = find_link_by(Link::RELATIONS[:edit])
        link_to(link, :Document, :http_method => 'post', :post_body => properties)
      end
    end
  end
end