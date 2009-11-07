require "spec_helper"

module Antelope
  module Parser
    describe GrammarRuleParser do
      before do
        @parser = GrammarRuleParser.new
      end

      it "should be able to parse a rule with a string as the body" do
        @parser.parse("foo->'bar';").should_not be_nil
      end

      it "should be able to parse an AND in the body (one element preceding the next)" do
        @parser.parse("foo-> 'bar' 'baz';").should_not be_nil
      end

      it "should be able to parse it with multiple spaces" do
        @parser.parse("foo -> 'bar'     'baz';").should_not be_nil
      end

      it "should allow a regex next to a string" do
        @parser.parse("foo -> 'bar' /baz/;").should_not be_nil
      end

      it "should allow a reference to a different rule" do
        @parser.parse("foo -> bar;").should_not be_nil
      end

      it "should allow a reference to two rules" do
        pending do
          @parser.parse("foo -> bar baz;").should_not be_nil
        end
      end
    end
  end
end
