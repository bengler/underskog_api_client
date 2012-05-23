require 'underskog/error/client_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 404
  class Error::NotFound < Underskog::Error::ClientError
  end
end
