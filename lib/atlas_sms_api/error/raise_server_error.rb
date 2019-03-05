require "faraday"
require "AtlasSmsApi/error/error"

module AtlasSmsApi
  module Error
    class RaiseServerError < Faraday::Response::Middleware
      def on_complete(env)
        status  = env[:status].to_i
        headers = env[:response_headers]

        case status
        when 503
          message = "503 No server is available to handle this request."
          raise AtlasSmsApi::Error::ServiceUnavailable.new message, headers
        end
      end
    end
  end
end
