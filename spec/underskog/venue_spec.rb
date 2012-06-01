require 'helper'

describe Underskog::Venue do

  describe "#==" do
    it "should return true when ids and classes are equal" do
      venue = Underskog::Venue.new('id' => 1)
      other = Underskog::Venue.new('id' => 1)
      (venue == other).should be_true
    end
    it "should return false when classes are not equal" do
      user = Underskog::User.new('id' => 1)
      venue = Underskog::Venue.new('id' => 1)
      (user == venue).should be_false
    end
    it "should return false when ids are not equal" do
      venue = Underskog::Venue.new('id' => 1)
      other = Underskog::Venue.new('id' => 2)
      (venue == other).should be_false
    end
  end

  describe "#created_at" do
    it "should return a Time when created_at is set" do
      venue = Underskog::Venue.new('created_at' => "Mon Jul 16 12:59:01 +0000 2007")
      venue.created_at.should be_a Time
    end
    it "should return nil when created_at is not set" do
      venue = Underskog::Venue.new
      venue.created_at.should be_nil
    end
  end

  describe "#updated_at" do
    it "should return a Time when updated_at is set" do
      venue = Underskog::Venue.new('updated_at' => "Mon Jul 16 12:59:01 +0000 2007")
      venue.updated_at.should be_a Time
    end
    it "should return nil when updated_at is not set" do
      venue = Underskog::Venue.new
      venue.updated_at.should be_nil
    end
  end

  describe "#created_by" do
    it "should return a User when creator is set" do
      venue = Underskog::Venue.new('creator' => {"id" => 1, "name" => "foo"})
      venue.created_by.should == Underskog::User.new("id" => 1, "name" => "foo")
    end
    it "should return nil when creator is not set" do
      venue = Underskog::Venue.new
      venue.created_by.should be_nil
    end
  end

  describe "#updated_by" do
    it "should return a User when updater is set" do
      venue = Underskog::Venue.new('updater' => {"id" => 1, "name" => "foo"})
      venue.updated_by.should == Underskog::User.new("id" => 1, "name" => "foo")
    end
    it "should return nil when updater is not set" do
      venue = Underskog::Venue.new
      venue.updated_by.should be_nil
    end
  end

end
