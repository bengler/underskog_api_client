require 'time'

module Underskog
  module Creatable

    # Time when the object was created on Underskog
    #
    # @return [Time]
    def created_at
      @created_at ||= Time.parse(@attrs['created_at']) unless @attrs['created_at'].nil?
    end

    # The use which created the object
    #
    # @return Underskog::User
    def created_by
      @created_by ||= Underskog::User.new(@attrs['creator']) if
        @attrs['creator'].is_a?(Hash) and !@attrs['creator'].empty?
    end
  end
end
