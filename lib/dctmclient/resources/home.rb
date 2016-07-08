module Dctmclient
  # This class is the only entry to consume REST Services by providing a REST Services home
  # page URL as initialization.

  class Home < SingleResource
    def initialize(home_url)
      response = Request.new(home_url, 'get', {:headers => {"Accept" => 'application/home+json'}}).execute
      super(response)
    end

    def repositories(params = {})
      url = @representation["resources"]["http://identifiers.emc.com/linkrel/repositories"]["href"]
      link = Link.new('repositories', url)
      return navigate(link, 'get', :Repositories, {:params => params})
    end

    def product_info
      url = @representation["resources"]["about"]["href"]
      link = Link.new('product-info', url)
      return navigate(link, 'get', :ProductInfo)
    end
  end

end