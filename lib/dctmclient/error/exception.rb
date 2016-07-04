module Dctmclient
  class BasicException < Exception
  end

  class NavigationException < BasicException
  end

  class RequestException < BasicException
  end
end