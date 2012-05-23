require 'active_support/core_ext/hash/except'
require 'underskog/base'
require 'underskog/client'
require 'underskog/creatable'
require 'underskog/user'

module Underskog
  class Event < Underskog::Base

    include Underskog::Creatable
    lazy_attr_reader :id, :title

    # @param other [Twiter::Status]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

  end
end
