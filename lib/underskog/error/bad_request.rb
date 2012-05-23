require 'underskog/error/client_error'

module Underskog
  # Raised when Underskog returns the HTTP status code 400
  class Error::BadRequest < Underskog::Error::ClientError
  end
end
