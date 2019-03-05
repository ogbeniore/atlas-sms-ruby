module AtlasSmsApi
  module Error
    class Error < StandardError
      attr_reader :http_headers

      def initialize(message, http_headers)
        @http_headers = http_headers
        super(message)
      end
    end # Error
  end

  module Error
    class ServerError < AtlasSmsApi::Error::Error; end
  end

  module Error
    class ServiceUnavailable < AtlasSmsApi::Error::ServerError; end
  end

  module Error
    class ClientError < AtlasSmsApi::Error::Error; end
  end

  module Error
    class Forbidden < AtlasSmsApi::Error::ClientError; end
  end

  module Error
    class BadRequest < AtlasSmsApi::Error::ClientError; end
  end

  module Error
    class RequestTooLarge < AtlasSmsApi::Error::ClientError; end
  end
end
