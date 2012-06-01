require 'helper'

describe Underskog::User do

  describe "#==" do
    it "should return true when ids and classes are equal" do
      user = Underskog::User.new('id' => 1)
      other = Underskog::User.new('id' => 1)
      (user == other).should be_true
    end
    it "should return false when classes are not equal" do
      user = Underskog::User.new('id' => 1)
      other = Underskog::Event.new('id' => 1)
      (user == other).should be_false
    end
    it "should return false when ids are not equal" do
      user = Underskog::User.new('id' => 1)
      other = Underskog::User.new('id' => 2)
      (user == other).should be_false
    end
  end

  describe "#created_at" do
    it "should return a Time when created_at is set" do
      user = Underskog::User.new('created_at' => "Mon Jul 16 12:59:01 +0000 2007")
      user.created_at.should be_a Time
    end
    it "should return nil when created_at is not set" do
      user = Underskog::User.new
      user.created_at.should be_nil
    end
  end

  describe "#updated_at" do
    it "should return a Time when updated_at is set" do
      user = Underskog::User.new('updated_at' => "Mon Jul 16 12:59:01 +0000 2007")
      user.updated_at.should be_a Time
    end
    it "should return nil when updated_at is not set" do
      user = Underskog::User.new
      user.updated_at.should be_nil
    end
  end

end
