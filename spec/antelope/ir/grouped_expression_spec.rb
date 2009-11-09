require "spec_helper"

module Antelope
  module IR
    describe GroupedExpression do
      it "should have a list of expressions" do
        expr = Object.new
        grouped = GroupedExpression.new([expr])
        grouped.expressions.should == [expr]
      end
    end
  end
end