require 'active_support/core_ext/hash/except'
require 'underskog/base'
require 'underskog/client'
require 'underskog/creatable'
require 'underskog/updatable'
require 'underskog/locationable'

module Underskog
  class Venue < Underskog::Base
    include Underskog::Creatable
    include Underskog::Updatable
    include Underskog::Locationable
    lazy_attr_reader :id, :title, :body, :address, :postcode,
      :home_url, :ticket_directions, :tags, :flickr_tag, :city, :url, :location

    # @param other [Underskog::Venue]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

  end
end
