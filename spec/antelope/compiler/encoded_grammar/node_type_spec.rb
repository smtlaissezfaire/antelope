require "spec_helper"

module Antelope
  module Compiler
    describe EncodedGrammar do
      it "should have the list of node types" do
        EncodedGrammar::NODE_TYPES.should == [1,2,3,4,5,6,7]
      end

      it "should have a Rule = 1" do
        EncodedGrammar::RULE.should == 1
      end
    end
  end
end