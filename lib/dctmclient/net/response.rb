module Dctmclient
  module Net
    class Response
      attr_reader :http_status_code, :body, :http_headers

      def initialize(http_status_code, body, http_headers = {})
        @http_status_code = http_status_code
        @body = body
        @http_headers = http_headers
      end

      def inspect
        "code:#{@http_status_code}\n headers:#{@http_headers}\n body:#{body}"
      end

      def to_s
        inspect
      end
    end
  end
end