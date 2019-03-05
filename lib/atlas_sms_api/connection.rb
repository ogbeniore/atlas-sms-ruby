require "faraday"
require "faraday_middleware"
require "busibe/error/raise_client_error"
require "busibe/error/raise_server_error"

module AtlasSmsApi
  module Connection
    private
    
      def connection(options)
        default_options = {
          url: options.fetch(:emdpoint, enpoint)
        }

        @connection ||= Faraday.new(default_options) do |faraday|
          faraday.use(
            Faraday::Request::BasicAuthentication,
            options[:access_key],
            options[:secret_key]
          )

          faraday.use AtlasSmsApi::Error::RaiseClientError
          faraday.use AtlasSmsApi::Error::RaiseServerError
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
  end
end