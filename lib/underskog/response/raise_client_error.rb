require 'faraday'
require 'underskog/error/bad_request'
require 'underskog/error/forbidden'
require 'underskog/error/not_acceptable'
require 'underskog/error/not_found'
require 'underskog/error/unauthorized'

module Underskog
  module Response
    class RaiseClientError < Faraday::Response::Middleware

      def on_complete(env)
        case env[:status].to_i
        when 400
          raise Underskog::Error::BadRequest.new(error_body(env[:body]), env[:response_headers])
        when 401
          raise Underskog::Error::Unauthorized.new(error_body(env[:body]), env[:response_headers])
        when 403
          raise Underskog::Error::Forbidden.new(error_body(env[:body]), env[:response_headers])
        when 404
          raise Underskog::Error::NotFound.new(error_body(env[:body]), env[:response_headers])
        when 406
          raise Underskog::Error::NotAcceptable.new(error_body(env[:body]), env[:response_headers])
        end
      end

    private

      def error_body(body)
        if body.nil?
          ''
        elsif body['error']
          body['error']
        elsif body['errors']
          first = Array(body['errors']).first
          if first.kind_of?(Hash)
            first['message'].chomp
          else
            first.chomp
          end
        end
      end

    end
  end
end
