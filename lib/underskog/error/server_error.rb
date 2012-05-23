require 'underskog/error'

module Underskog
  # Raised when Underskog returns a 5xx HTTP status code
  class Error::ServerError < Underskog::Error
  end
end
