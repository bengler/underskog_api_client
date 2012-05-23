require 'active_support/core_ext/hash/except'
require 'underskog/authenticatable'
require 'underskog/base'
require 'underskog/creatable'

module Underskog
  class User < Underskog::Base
    include Underskog::Authenticatable
    include Underskog::Creatable
    lazy_attr_reader :id, :name, :realname, :description, :image_url,
      :email, :home_url, :gardener, :season_pass_active

    # @param other [Underskog::User]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

  end
end
