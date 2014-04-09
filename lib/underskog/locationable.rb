require 'time'

module Underskog

  class Location
    attr_reader :lat, :lon
    def initialize(lat, lon)
      @lat = lat
      @lon = lon
    end
  end

  module Locationable

    # @return [Location]
    def geolocation
      if @attrs['location'] and @attrs['location']['lat'] and @attrs['location']['lon']
        return @location ||= Underskog::Location.new(@attrs['location']['lat'],@attrs['location']['lon'] )
      end
    end
  end
end
