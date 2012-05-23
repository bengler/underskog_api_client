require 'underskog/error/server_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 503
  class Error::ServiceUnavailable < Underskog::Error::ServerError
  end
end
