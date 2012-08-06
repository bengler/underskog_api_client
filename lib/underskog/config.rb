require 'underskog/version'

module Underskog
  # Defines constants and methods related to configuration
  module Config

    # The HTTP connection adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # The Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    # The gateway server if none is set
    DEFAULT_GATEWAY = nil

    # The proxy server if none is set
    DEFAULT_PROXY = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://underskog.no'

    # The oauth token if none is set
    DEFAULT_ACCESS_TOKEN = nil

    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "Underskog API Client Ruby Gem #{Underskog::Version}"

    # An array of valid keys in the options hash when configuring a {Underskog::Client}
    VALID_OPTIONS_KEYS = [
      :access_token,
      :adapter,
      :connection_options,
      :endpoint,
      :gateway,
      :proxy,
      :user_agent
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.access_token       = DEFAULT_ACCESS_TOKEN
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.endpoint           = DEFAULT_ENDPOINT
      self.gateway            = DEFAULT_GATEWAY
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
      self
    end

  end
end
