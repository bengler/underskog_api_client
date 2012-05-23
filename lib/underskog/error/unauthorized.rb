require 'underskog/error/client_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 401
  class Error::Unauthorized < Underskog::Error::ClientError
  end
end
