require 'helper'

describe Underskog::EventParticipation do


  describe "#user" do
    it "should return a User object" do
      ep = Underskog::EventParticipation.new({"id" => 23,"name" => "marika","image_url" => "http://underskog.no/cache/image/38250_48x48_cu.png","kind" => "attend", "event_id" => 2})
      ep.user.should be_a Underskog::User
    end
    it "should return nil when user is not set" do
      ep = Underskog::EventParticipation.new
      ep.user.should be_nil
    end
  end

  describe "#event" do
    it "should return a Event object" do
      ep = Underskog::EventParticipation.new({"id" => 23,"name" => "marika","image_url" => "http://underskog.no/cache/image/38250_48x48_cu.png","kind" => "attend", "event_id" => 2})
      ep.event.should be_a Underskog::Event
    end
    it "should return nil when event is not set" do
      ep = Underskog::EventParticipation.new
      ep.event.should be_nil
    end
  end

end
