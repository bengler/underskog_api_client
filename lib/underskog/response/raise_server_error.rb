require 'faraday'
require 'underskog/error/bad_gateway'
require 'underskog/error/internal_server_error'
require 'underskog/error/service_unavailable'

module Underskog
  module Response
    class RaiseServerError < Faraday::Response::Middleware

      def on_complete(env)
        case env[:status].to_i
        when 500
          raise Underskog::Error::InternalServerError.new("Something is technically wrong.", env[:response_headers])
        when 502
          raise Underskog::Error::BadGateway.new("Underskog is down or being upgraded.", env[:response_headers])
        when 503
          raise Underskog::Error::ServiceUnavailable.new("(__-){ Underskog is over capacity.", env[:response_headers])
        end
      end

    end
  end
end
