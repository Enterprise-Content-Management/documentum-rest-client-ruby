module Dctmclient
   class Response
    attr_accessor :code, :body, :headers
    def initialize(code, body, headers = {})
      @code, @body, @headers = code, body, headers
    end

    def code
      return @code
    end

    def body
      return @body
    end

    def headers
      return @headers
    end
  end

end