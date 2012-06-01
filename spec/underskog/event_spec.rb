require 'helper'

describe Underskog::Event do

  describe "#==" do
    it "should return true when ids and classes are equal" do
      event = Underskog::Event.new('id' => 1)
      other = Underskog::Event.new('id' => 1)
      (event == other).should be_true
    end
    it "should return false when classes are not equal" do
      user = Underskog::User.new('id' => 1)
      event = Underskog::Event.new('id' => 1)
      (user == event).should be_false
    end
    it "should return false when ids are not equal" do
      event = Underskog::Event.new('id' => 1)
      other = Underskog::Event.new('id' => 2)
      (event == other).should be_false
    end
  end

  describe "#start_time" do
    it "should return a Time when time is set" do
      event = Underskog::Event.new('time' => "Mon Jul 16 12:59:01 +0000 2007")
      event.start_time.should be_a Time
    end
    it "should return nil when start is not set" do
      event = Underskog::Event.new
      event.start_time.should be_nil
    end
  end

  describe "#created_at" do
    it "should return a Time when created_at is set" do
      event = Underskog::Event.new('created_at' => "Mon Jul 16 12:59:01 +0000 2007")
      event.created_at.should be_a Time
    end
    it "should return nil when created_at is not set" do
      event = Underskog::Event.new
      event.created_at.should be_nil
    end
  end

  describe "#updated_at" do
    it "should return a Time when updated_at is set" do
      event = Underskog::Event.new('updated_at' => "Mon Jul 16 12:59:01 +0000 2007")
      event.updated_at.should be_a Time
    end
    it "should return nil when updated_at is not set" do
      event = Underskog::Event.new
      event.updated_at.should be_nil
    end
  end

  describe "#created_by" do
    it "should return a User when creator is set" do
      event = Underskog::Event.new('creator' => {"id" => 1, "name" => "foo"})
      event.created_by.should == Underskog::User.new("id" => 1, "name" => "foo")
    end
    it "should return nil when creator is not set" do
      event = Underskog::Event.new
      event.created_by.should be_nil
    end
  end

  describe "#updated_by" do
    it "should return a User when updater is set" do
      event = Underskog::Event.new('updater' => {"id" => 1, "name" => "foo"})
      event.updated_by.should == Underskog::User.new("id" => 1, "name" => "foo")
    end
    it "should return nil when updater is not set" do
      event = Underskog::Event.new
      event.updated_by.should be_nil
    end
  end

end
