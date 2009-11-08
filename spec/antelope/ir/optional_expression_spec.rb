require "spec_helper"

module Antelope
  module IR
    describe OptionalExpression do
      it "should have an expression" do
        expr = Object.new
        optional = OptionalExpression.new(expr)
        optional.expression.should equal(expr)
      end
    end
  end
end