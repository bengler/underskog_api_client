require 'underskog/error/server_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 502
  class Error::BadGateway < Underskog::Error::ServerError
  end
end
