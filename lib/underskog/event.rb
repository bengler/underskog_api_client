require 'active_support/core_ext/hash/except'
require 'underskog/base'
require 'underskog/client'
require 'underskog/creatable'
require 'underskog/updatable'
require 'underskog/user'
require 'underskog/venue'

module Underskog
  class Event < Underskog::Base
    include Underskog::Creatable
    include Underskog::Updatable
    lazy_attr_reader :id, :title, :body, :canceled, :home_url,
      :private, :ticket_directions, :tags, :venue

    # @param other [Underskog::Event]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

    def venue
      @venue ||= Underskog::Venue.new(@attrs['venue'])
    end

    def start_time
      @start_time ||= Time.parse(@attrs['time'])
    end

  end
end
