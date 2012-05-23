require 'helper'

describe Underskog do
  after do
    Underskog.reset
  end

  describe '.respond_to?' do
    it "should take an optional argument" do
      Underskog.respond_to?(:new, true).should be_true
    end
  end

  describe ".new" do
    it "should return a Underskog::Client" do
      Underskog.new.should be_a Underskog::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Underskog.adapter.should == Underskog::Config::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Underskog.adapter = :typhoeus
      Underskog.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Underskog.endpoint.should == Underskog::Config::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Underskog.endpoint = 'http://tumblr.com/'
      Underskog.endpoint.should == 'http://tumblr.com/'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Underskog.user_agent.should == Underskog::Config::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Underskog.user_agent = 'Custom User Agent'
      Underskog.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do
    Underskog::Config::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Underskog.configure do |config|
          config.send("#{key}=", key)
          Underskog.send(key).should == key
        end
      end
    end
  end

end
