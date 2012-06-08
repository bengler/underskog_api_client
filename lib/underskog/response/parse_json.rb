require 'faraday'
require 'multi_json'

module Underskog
  module Response
    class ParseJson < Faraday::Response::Middleware

      def parse(body)
          case body
          when ''
            nil
          when 'true'
            true
          when 'false'
            false
          else
            json = MultiJson.load(body)
            return json['data'] if json.is_a?(Hash) and json['data']
            json
          end
      end

      def on_complete(env)
        if respond_to? :parse
          env[:body] = parse(env[:body]) unless env[:request][:raw] or [204,304].index env[:status]
        end
      end
    end
  end
end
