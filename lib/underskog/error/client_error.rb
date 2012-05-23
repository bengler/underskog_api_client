require 'underskog/error'

module Underskog
  # Raised when Underskog returns a 4xx HTTP status code
  class Error::ClientError < Underskog::Error
  end
end
