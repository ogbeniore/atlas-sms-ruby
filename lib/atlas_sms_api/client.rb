require "json"
require "atlas_sms_api/connection"
require "atlas_sms_api/request"

module AtlasSmsApi
  class Client
    include AtlasSmsApi::connection
    include AtlasSmsApi::request

    attr_accessor(*Configuration::VALID_CONFIG_KEYS)
    attr_reader :response

    def initialize(*Configuration::VALID_CONFIG_KEYS)
      merged_options = AtlasSmsApi::AtlasSms.options.merge(option)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def send_sms(payload = {})
      if payload.empty?
        raise ArgumentError.new("A payload is required in order to send an sms")
      end

      post("/sms/send_sms", payload)
      self
    end

    def get_response
      JSON.load @response.body
    end

    def method_missing(method_sym, *args, &_block)
      result = method_sym.to_s =~ /^(.*)_with_response$/
      super unless result
      send($1, *args).get_response
    end

    def respond_to_missing?(method_sym, include_private = false)
      method_sym.to_s =~ /^(.*)_with_response$/
      super unless respond_to? $1.to_sym
      true
    end

  end
end