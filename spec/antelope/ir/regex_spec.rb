require "spec_helper"

module Antelope
  module IR
    describe Regex do
      it "should have text" do
        regex = Regex.new
        regex.text = "foo"
        regex.text.should == "foo"
      end
    end
  end
end