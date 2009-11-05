require "spec_helper"

module Antelope
  module IR
    describe Literal do
      it "should have text" do
        literal = Literal.new
        literal.text = "foo"
        literal.text.should == "foo"
      end
    end
  end
end