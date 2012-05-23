require 'underskog/error/client_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 406
  class Error::NotAcceptable < Underskog::Error::ClientError
  end
end
