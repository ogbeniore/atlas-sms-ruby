module AtlasSmsApi
  module Request
    def get(path, params = {})
      perform_request(
        :get,
        path,
        params,
        access_key: @access_key, secret_key: @secret_key
      )
    end

    def post(path, params = {})
      perform_request(
        :post,
        path,
        params,
        access_key: @access_key, secret_key: @secret_key
      )
    end

    private

    def perform_request(method, path, params, options)
      @connection = connection(options)
      @response = @connection.run_request(
        method,
        path,
        params,
        nil
      ) do |request|
        request.options[:raw] = true if options[:raw]

        case method.to_sym
        when :get
          request.url(path, params)
        when :post
          request.path = path
          request.body = params unless params.empty?
        end
      end

      options[:raw] ? @response : @response.body
    end
  end
end
