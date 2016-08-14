module Dctmclient
  module Resources
    class Home < AbstractSingleResource
      def initialize(rest_services_url)
        response = Dctmclient::Net::Request.new(
            rest_services_url,
            'get', nil,
            {"Accept" => 'application/home+json'}
        ).execute
        super(response)
      end

      def repositories(query_params = {})
        href = representation_json['resources'][Link::RELATIONS[:repositories]]['href']
        link_to(Link.new('repositories', href), :Repositories, :query_params => query_params)
      end

      def product_info
        href = representation_json['resources']['about']['href']
        link_to(Link.new('product-info', href), :ProductInfo)
      end
    end
  end
end