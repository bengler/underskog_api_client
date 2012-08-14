require 'helper'

describe Underskog::Client do

  before do
    @client = Underskog::Client.new
  end

  describe "#send_message" do
    before do
      stub_request(:post, "https://underskog.no/api/v1/messages/skogsmaskin").
               with(:body => {"access_token"=>true, "body"=>"foo", :id => "skogsmaskin"},
                    :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/x-www-form-urlencoded'}).
               to_return(:status => 200, :body => '{"message":"Sent"}', :headers => {})
    end
    it "should request the correct resource" do
      @client.send_message('skogsmaskin', {:body => "foo"})
      a_post("/api/v1/messages/skogsmaskin").
        should have_been_made
    end
  end

end