require 'helper'

describe Underskog::Client do

  before do
    @client = Underskog::Client.new
  end

  describe "#user" do
    context "with a user ID passed" do
      before do
        stub_request(:get, "https://localhost/api/v1/users/831?access_token&id=831").
          with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
          to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "should request the correct resource" do
        @client.user(831)
        a_get("/api/v1/users/831?access_token&id=831").
          should have_been_made
      end
    end
    context "with a user object passed" do
      context "with a user ID" do
        before do
          stub_request(:get, "https://localhost/api/v1/users/831?access_token&id=831").
            with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
            to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end
        it "should request the correct resource" do
          user = Underskog::User.new('id' => 831)
          @client.user(user)
          a_get("/api/v1/users/831?access_token&id=831").
            should have_been_made
        end
      end
    end
    context "without a user ID passed" do
      before do
        stub_request(:get, "https://localhost/api/v1/users/current?access_token").
          with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
          to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "should request the correct resource" do
        @client.user
        a_get("/api/v1/users/current?access_token").
          should have_been_made
      end
    end
  end
  describe "#user?" do
    before do
      stub_request(:get, "https://localhost/api/v1/users/831?access_token&id=831").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      stub_request(:get, "https://localhost/api/v1/users/23423432?access_token&id=23423432").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:status => 404, :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @client.user?(831)
      a_get("/api/v1/users/831?access_token&id=831").
        should have_been_made
    end
    it "should return true if user exists" do
      user = @client.user?(831)
      user.should be_true
    end
    it "should return false if user does not exist" do
      user = @client.user?(23423432)
      user.should be_false
    end
  end

  describe "#circle" do
    before do
      stub_request(:get, "https://localhost/api/v1/users/831?access_token&id=831").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      stub_request(:get, "https://localhost/api/v1/users/831/circle?access_token&id=831&page=2").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => "[]", :headers => {:content_type => "application/json; charset=utf-8"})
      stub_request(:get, "https://localhost/api/v1/users/831/circle?access_token&id=831&page=1").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'}).
        to_return(:body => fixture("skogsmaskin_circle.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      circle = @client.user(831).circle
      a_get("/api/v1/users/831/circle?access_token&id=831&page=1").
        should have_been_made
      circle.last.class.should == Underskog::User
    end
  end

end
