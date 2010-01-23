require "spec_helper"

module Antelope
  module IR
    describe Repetition do
      it "should allow for one expression" do
        one = Object.new
        one_or_more = Repetition.new(one)
        one_or_more.expression.should == one
      end

      it "should raise if none are given" do
        lambda {
          Repetition.new
        }.should raise_error(ArgumentError)
      end
    end
  end
end