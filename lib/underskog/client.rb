require 'underskog/config'
require 'underskog/connection'
require 'underskog/core_ext/hash'
require 'underskog/error/forbidden'
require 'underskog/error/not_found'
require 'underskog/event'
require 'underskog/event_participation'
require 'underskog/request'
require 'underskog/user'

module Underskog
  # Wrapper for the Underskog REST API
  class Client

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
    #   @param user [Integer, String, Underskog::User] A Underskog user ID, name or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Underskog::User] The requested user.
    def user(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if user = args.pop
        options.merge_user!(user)
        user = get("api/v1/users/#{options[:id]}", options)
      else
        user = get("/api/v1/users/current", options)
      end
      Underskog::User.new(user)
    end

    # Returns true if the specified user exists
    #
    # @param user [Integer, String, Underskog::User] A Underskog user ID, name or object.
    # @return [Boolean] true if the user exists, otherwise false.
    # @requires_authentication Yes
    def user?(user, options={})
      options.merge_user!(user)
      get("api/v1/users/#{options[:id]}", options, :raw => true)
      true
    rescue Underskog::Error::NotFound
      false
    end

    # Returns the network (circle) for a user
    #
    # @requires_authentication Yes
    # @overload user(user, options={})
    #   @param user [Integer, String, Underskog::User] A Underskog user ID, name or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Array[Underskog::User]] Array of users.
    def circle(*args)
      options = {}
      options.merge!(args.last.is_a?(Hash) ? args.pop : {})
      options[:page] ||= 1
      user = args.pop
      options.merge_user!(user)
      users = []
      circle_data = get("api/v1/users/#{options[:id]}/circle", options)
      circle_data.each {|u|
        users << Underskog::User.new(u)
      }
      users
    end

    # Returns extended information of a given event
    #
    # @requires_authentication Yes
    # @overload event(event, options={})
    #   @param event [Integer, Underskog::User] A Underskog user ID or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Underskog::User] The requested user.
    def event(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if event = args.pop
        options.merge_event!(event)
        event = get("api/v1/events/#{options[:id]}", options)
        Underskog::Event.new(event)
      end
    end

    # Set RSVP for a given event
    #
    # @requires_authentication Yes
    # @overload event(event, options={})
    #   @param event [Integer, Underskog::Event] A Underskog event ID or object.
    #   @param options [Hash] A customizable set of options (i.e. {:kind => 'attend'}).
    #   @return [boolean] True if the event participation was set, false otherwise
    def rsvp(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if event = args.pop
        options.merge_event!(event)
        returned_event = post("api/v1/events/#{options[:id]}/rsvp", options)
        return true if event == Underskog::Event.new(returned_event)
      end
      false
    end

    # Returns participations for a given event
    #
    # @requires_authentication Yes
    # @overload event(event, options={})
    #   @param event [Integer, Underskog::Event] A Underskog event ID or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Array[Underskog::EventParticipation]]
    def participations(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if event = args.pop
        options.merge_event!(event)
        participations = []
        participation_data = get("api/v1/events/#{options[:id]}/participations", options)
        participation_data.each do |p|
          participations << Underskog::EventParticipation.new(p.merge("event_id" => options[:id]))
        end
        participations
      end
    end

    # Returns a user's events
    #
    # @requires_authentication Yes
    # @overload user(user, options={})
    #   @param user [Integer, String, Underskog::User] A Underskog user ID, name or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Array[Underskog::Event]] Array of events.
    def user_events(*args)
      options = {}
      options.merge!(args.last.is_a?(Hash) ? args.pop : {})
      options[:page] ||= 1
      user = args.pop
      options.merge_user!(user)
      events = []
      events_data = get("api/v1/users/#{options[:id]}/events", options)
      events_data.each do |e|
        events << Underskog::Event.new(e)
      end
      events
    end

    # Returns a user's circle events
    #
    # @requires_authentication Yes
    # @overload user(user, options={})
    #   @param user [Integer, String, Underskog::User] A Underskog user ID, name or object.
    #   @param options [Hash] A customizable set of options.
    #   @return [Array[Underskog::Event]] Array of events.
    def circle_events(*args)
      options = {}
      options.merge!(args.last.is_a?(Hash) ? args.pop : {})
      options[:page] ||= 1
      user = args.pop
      options.merge_user!(user)
      events = []
      events_data = get("api/v1/users/#{options[:id]}/events/circle", options)
      events_data.each do |e|
        events << Underskog::Event.new(e)
      end
      events
    end

    # Send message to a user
    #
    # @requires_authentication Yes
    # @overload send_message(user, options={:body => "foo"})
    #   @param user [Integer, String, Underskog::User] A Underskog user ID or object.
    #   @param options [Hash] A customizable set of options (i.e. {:body => 'foo'}).
    #   @return [boolean] True if the message was sent, false otherwise
    def send_message(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if user = args.pop
        options.merge_user!(user)
        response = post("api/v1/messages", options.merge(:recipient_id => options[:id]).except(:id))
        return true if response["message"] == "Message sent"
      end
      false
    end

  end
end
