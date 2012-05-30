require 'active_support/core_ext/hash/except'
require 'underskog/base'
require 'underskog/creatable'
require 'underskog/updatable'

module Underskog
  class User < Underskog::Base
    include Underskog::Creatable
    include Underskog::Updatable
    lazy_attr_reader :id, :name, :realname, :sex, :description, :image_url,
      :email, :home_url, :gardener, :season_pass_active, :friend

    # @param other [Underskog::User]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

    def circle(options={})
      Underskog.circle(self, options)
    end

    def events(options={})
      Underskog.user_events(self, options)
    end

    def circle_events(options={})
      Underskog.circle_events(self, options)
    end

  end
end
