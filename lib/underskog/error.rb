module Underskog
  # Custom error class for rescuing from all Underskog errors
  class Error < StandardError
    attr_reader :http_headers

    # Initializes a new Error object
    #
    # @param message [String]
    # @param http_headers [Hash]
    # @return [Underskog::Error]
    def initialize(message, http_headers)
      @http_headers = Hash[http_headers]
      super(message)
    end
  end
end
