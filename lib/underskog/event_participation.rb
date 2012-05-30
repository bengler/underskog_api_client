require 'active_support/core_ext/hash/except'
require 'underskog/base'

module Underskog
  class EventParticipation < Underskog::Base
    lazy_attr_reader :kind

    def user
      @user ||= Underskog::User.new(@attrs.except("kind").except("event_id"))
    end

    def event
      @event ||= Underskog.event(@attrs["event_id"])
    end

  end
end
