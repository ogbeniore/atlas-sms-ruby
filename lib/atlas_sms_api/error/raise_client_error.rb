require "faraday"

module AtlasSmsApi
  module Error
    class RaiseClientError < Faraday::Response::Middleware
      def on_complete(env)
        status  = env[:status].to_i
        body    = env[:body]
        headers = env[:response_headers]

        case status
        when 400
          raise AtlasSmsApi::Error::BadRequest.new body, headers
        when 403
          raise AtlasSmsApi::Error::Forbidden.new body, headers
        when 413
          raise AtlasSmsApi::Error::RequestTooLarge.new body, headers
        end
      end
    end # ClientError
  end
end
