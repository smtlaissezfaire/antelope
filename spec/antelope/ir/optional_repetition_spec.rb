require "spec_helper"

module Antelope
  module IR
    describe OptionalRepetition do
      it "should allow for one expression" do
        one = Object.new
        one_or_more = OptionalRepetition.new(one)
        one_or_more.expressions.should == [one]
      end

      it "should allow for two expressions" do
        one = Object.new
        two = Object.new
        one_or_more = OptionalRepetition.new(one, two)
        one_or_more.expressions.should == [one, two]
      end

      it "should raise if none are given" do
        lambda {
          OptionalRepetition.new
        }.should raise_error(ArgumentError)
      end
    end
  end
end