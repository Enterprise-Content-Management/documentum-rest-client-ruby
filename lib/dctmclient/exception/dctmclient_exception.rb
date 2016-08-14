module Dctmclient
  module Exception
    class DctmclientException < StandardError
    end

    class LinkNotFoundException < DctmclientException
    end

    class DctmclientRequestException <DctmclientException
    end
  end

end