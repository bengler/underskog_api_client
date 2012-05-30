require 'faraday'
require 'underskog/core_ext/hash'
require 'underskog/request/gateway'
require 'underskog/response/parse_json'
require 'underskog/response/raise_client_error'
require 'underskog/response/raise_server_error'

module Underskog
  module Connection
  private

    # Returns a Faraday::Connection object
    #
    # @param options [Hash] A hash of options
    # @return [Faraday::Connection]
    def connection(options={})
      default_options = {
        :headers => {
          :accept => 'application/json',
          :user_agent => user_agent,
        },
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => options.fetch(:endpoint, endpoint),
      }
      @connection ||=Faraday.new(default_options.deep_merge(connection_options)) do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Underskog::Response::RaiseClientError
        builder.use Underskog::Response::ParseJson
        builder.use Underskog::Response::RaiseServerError
        builder.use Underskog::Request::Gateway, gateway if gateway
        builder.adapter(adapter)
      end
    end
  end
end
