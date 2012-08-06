require 'helper'

describe Underskog::Client do

  before do
    @client = Underskog::Client.new
  end

  describe "#event" do
    before do
      stub_request(:get, "https://underskog.no/api/v1/events/1?access_token&id=1").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("event.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @client.event(1)
      a_get("/api/v1/events/1?access_token&id=1").
        should have_been_made
    end
  end

  describe "#participations" do
    before do
      stub_request(:get, "https://underskog.no/api/v1/events/1/participations?access_token&id=1").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("participations.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      stub_request(:get, "https://underskog.no/api/v1/events/1?access_token&id=1").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("event.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @client.participations(@client.event(1))
      a_get("/api/v1/events/1/participations?access_token&id=1").
        should have_been_made
    end
  end

  describe "#rsvp" do
    before do
      stub_request(:get, "https://underskog.no/api/v1/events/1?access_token&id=1").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("event.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      stub_request(:post, "https://underskog.no/api/v1/events/1/rsvp").
               with(:body => {"access_token"=>true, "id"=>"1"},
                    :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/x-www-form-urlencoded'}).
               to_return(:status => 200, :body => fixture("event.json"), :headers => {})
    end
    it "should request the correct resource" do
      @client.rsvp(@client.event(1))
      a_post("/api/v1/events/1/rsvp").
        should have_been_made
    end
  end

  describe "#circle_events" do
    before do
      stub_request(:get, "https://underskog.no/api/v1/users/1/events/circle?access_token&id=1&page=1").
               with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
               to_return(:status => 200, :body => fixture("events.json"), :headers => {})
    end
    it "should request the correct resource" do
      @client.circle_events(Underskog::User.new("id"=>1))
      a_get("/api/v1/users/1/events/circle?access_token&id=1&page=1").
        should have_been_made
    end
  end

  describe "#user_events" do
    before do
      stub_request(:get, "https://underskog.no/api/v1/users/1/events?access_token&id=1&page=1").
               with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
               to_return(:status => 200, :body => fixture("events.json"), :headers => {})
    end
    it "should request the correct resource" do
      @client.user_events(Underskog::User.new("id"=>1))
      a_get("/api/v1/users/1/events?access_token&id=1&page=1").
        should have_been_made
    end
  end

end