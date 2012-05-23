module Underskog
  module Authenticatable

    # Credentials hash
    #
    # @return [Hash]
    def credentials
      {
        :access_token => access_token
      }
    end

    # Check whether credentials are present
    #
    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

  end
end
