module Dctmclient
  #Basic Exception for Dctmclient
  class BasicException < Exception
  end

  # This exception would be raised, if a finding operation via id is called, while this object
  # doesn't exist in the entries collection.
  class NavigationException < BasicException
  end

  # This exception would be raised, when the status code, in the Dctcmclient::Response object
  # is not included by [200, 201, 204].
  class RequestException < BasicException
  end
end