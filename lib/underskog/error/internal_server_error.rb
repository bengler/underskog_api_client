require 'underskog/error/server_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 500
  class Error::InternalServerError < Underskog::Error::ServerError
  end
end
