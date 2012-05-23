require 'underskog/error/client_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 403
  class Error::Forbidden < Underskog::Error::ClientError
  end
end
