require 'helper'

describe Underskog::Client do

  before do
    @client = Underskog::Client.new
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
      circle = @client.circle(@client.user(831))
      a_get("/api/v1/users/831/circle?access_token&id=831&page=1").
        should have_been_made
      circle.last.class.should == Underskog::User
    end
  end

end
