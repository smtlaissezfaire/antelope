require "spec_helper"

describe Antelope do
  describe "VERSION" do
    it "should be at 0.0.0" do
      Antelope::Version.string.should == "0.0.0"
    end
    
    it "should have major as 0" do
      Antelope::Version.major.should == 0
    end
    
    it "should have minor as 0" do
      Antelope::Version.minor.should == 0
    end
    
    it "should have tiny as 0" do
      Antelope::Version.tiny.should == 0
    end
  end
end