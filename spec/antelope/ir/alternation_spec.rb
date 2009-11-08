require "spec_helper"

module Antelope
  module IR
    describe Alternation do
      it "should initialize with 2 alternatives" do
        Alternation.new(1, 2).alternatives.should == [1, 2]
      end

      it "should use the correct values" do
        Alternation.new(2, 3).alternatives.should == [2,3]
      end

      it "should raise if given only one argument" do
        lambda {
          Alternation.new(1)
        }.should raise_error(ArgumentError)
      end
    end
  end
end
