require 'underskog/client'
require 'underskog/config'

module Underskog
  extend Config
  class << self
    # Alias for Underskog::Client.new
    #
    # @return [Underskog::Client]
    def new(options={})
      Underskog::Client.new(options)
    end

    # Delegate to Underskog::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
