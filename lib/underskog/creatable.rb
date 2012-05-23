require 'time'

module Underskog
  module Creatable

    # Time when the object was created on Underskog
    #
    # @return [Time]
    def created_at
      @created_at ||= Time.parse(@attrs['created_at']) unless @attrs['created_at'].nil?
    end

    # Time when the object was updated at on Underskog
    #
    # @return [Time]
    def updated_at
      @created_at ||= Time.parse(@attrs['updated_at']) unless @attrs['updated_at'].nil?
    end

  end
end
