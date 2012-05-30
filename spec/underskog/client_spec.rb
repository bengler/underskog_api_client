require 'helper'

describe Underskog::Client do
  before do
    @keys = Underskog::Config::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do

    before do
      Underskog.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Underskog.reset
    end

    it "should inherit module configuration" do
      api = Underskog::Client.new
      @keys.each do |key|
        api.send(key).should == key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :gateway => nil,
          :proxy => nil,
          :access_token => 'AT',
          :adapter => :typhoeus,
          :endpoint => 'http://tumblr.com/',
          :user_agent => 'Custom User Agent',
          :connection_options => {:timeout => 10},
        }
      end

      context "during initialization" do
        it "should override module configuration" do
          api = Underskog::Client.new(@configuration)
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end
      end

      context "after initilization" do
        it "should override module configuration after initialization" do
          api = Underskog::Client.new
          @configuration.each do |key, value|
            api.send("#{key}=", value)
          end
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end
      end

    end
  end

  it "should not cache the screen name across clients" do
    stub_request(:get, "https://localhost/api/v1/users/current?access_token").
      to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    client1 = Underskog::Client.new
    client1.current_user.name.should == 'skogsmaskin'
    stub_request(:get, "https://localhost/api/v1/users/current?access_token").
      to_return(:body => fixture("even.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    client2 = Underskog::Client.new
    client2.current_user.name.should == 'even'
  end

  it "should recursively merge connection options" do
    ua = 'Custom User Agent'
    stub_request(:get, "https://localhost/api/v1/users/831?access_token&id=831").
      with(:headers => {"Accept" => "application/json", "User-Agent" => ua}).
      to_return(:body => fixture("skogsmaskin.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    client = Underskog::Client.new(:connection_options => {:headers => {:user_agent => ua}})
    client.user(831)
    a_get("/api/v1/users/831?access_token&id=831").
      with(:headers => {"User-Agent" => ua}).
      should have_been_made
  end

end
