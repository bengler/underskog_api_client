require 'time'

module Underskog
  module Updatable

    # Time when the object was updated at on Underskog
    #
    # @return [Time]
    def updated_at
      @updated_at ||= Time.parse(@attrs['updated_at']) unless @attrs['updated_at'].nil?
    end

    # The use which updated the object
    #
    # @return Underskog::User
    def updated_by
      @updated_by ||= Underskog::User.new(@attrs['updater']) if
        @attrs['updater'].is_a?(Hash) and !@attrs['updater'].empty?
    end

  end
end
