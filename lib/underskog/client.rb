require 'underskog/authenticatable'
require 'underskog/config'
require 'underskog/connection'
require 'underskog/core_ext/hash'
require 'underskog/cursor'
require 'underskog/error/forbidden'
require 'underskog/error/not_found'
require 'underskog/event'
require 'underskog/request'
require 'underskog/user'

module Underskog
  # Wrapper for the Underskog REST API
  class Client

    include Underskog::Authenticatable
    include Underskog::Connection
    include Underskog::Request

    attr_accessor *Config::VALID_OPTIONS_KEYS

    # Initializes a new API object
    #
    # @param attrs [Hash]
    # @return [Underskog::Client]
    def initialize(attrs={})
      attrs = Underskog.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    # Returns the authenticated user
    #
    # @return [Underskog::User]
    def current_user
      @current_user ||= begin
        Underskog.user
      rescue Underskog::Error::Unauthorized
        nil
      end
    end

    # Returns extended information of a given user
    #
    # @requires_authentication Yes
    # @overload user(user, options={})
    #   @param user [Integer, Underskog::User] A Underskog user ID or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Underskog::User] The requested user.
    def user(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if user = args.pop
        options.merge_user!(user)
        user = get("api/v1/users/#{options[:user_id]}", options.tap{|o| o.delete(:user_id) })
      else
        user = get("/api/v1/users/current", options.tap{|o| o.delete(:user_id) })
      end
      Underskog::User.new(user)
    end

    # Returns true if the specified user exists
    #
    # @param user [Integer, Underskog::User] A Underskog user ID or object.
    # @return [Boolean] true if the user exists, otherwise false.
    # @requires_authentication Yes
    def user?(user, options={})
      options.merge_user!(user)
      get("api/v1/users/#{options[:user_id]}", options.tap{|o| o.delete(:user_id) }, :raw => true)
      true
    rescue Underskog::Error::NotFound
      false
    end

  end
end
