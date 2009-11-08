require "spec_helper"

module Antelope
  module Parser
    describe GrammarRuleParser do
      before do
        @parser = GrammarRuleParser.new
      end

      describe "parsing" do
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
          @parser.parse("foo -> bar baz;").should_not be_nil
        end

        it "should allow a reference to multiple rules" do
          @parser.parse("foo -> bar baz baz;").should_not be_nil
        end

        it "should allow an OR expression" do
          @parser.parse("foo -> bar | baz;").should_not be_nil
        end

        it "should allow multiple spaces between or expressions" do
          @parser.parse("foo -> bar     |    baz;").should_not be_nil
        end

        it "should allow multiple OR expressions" do
          @parser.parse("foo -> bar | baz | quxx;").should_not be_nil
        end

        it "should allow an OR with an AND expression" do
          @parser.parse("foo -> bar | baz quxx;").should_not be_nil
        end

        it "should allow an OR after an AND" do
          @parser.parse("foo -> bar baz | quxx;").should_not be_nil
        end

        it "should allow parens arond an expression" do
          @parser.parse("foo -> (bar);").should_not be_nil
        end

        it "should allow multiple parens around an expression" do
          @parser.parse("foo -> ((bar));").should_not be_nil
        end

        it "should allow parens around two expressions" do
          @parser.parse("foo -> (bar baz);").should_not be_nil
        end

        it "should allow parens around a subexpression" do
          @parser.parse("foo -> bar (baz quxx);").should_not be_nil
        end

        it "should allow parens around a left subexpression" do
          @parser.parse("foo -> (bar baz) quxx;").should_not be_nil
        end

        it "should allow parens around an OR" do
          @parser.parse("foo -> (foo | bar) baz;").should_not be_nil
        end

        it "should allow an optional expression with a question mark" do
          @parser.parse("foo -> bar?;").should_not be_nil
        end

        it "should allow an optional parenthesized expression with a question mark" do
          @parser.parse("foo -> (bar)?;").should_not be_nil
        end

        it "should allow an optional parenthesized expression with a question mark inside of it" do
          @parser.parse("foo -> (bar?);").should_not be_nil
        end

        it "should allow an optional parenthesized expression with a question of a string expression" do
          @parser.parse("foo -> \"bar\"?;").should_not be_nil
        end

        it "should allow an optional parenthesized expression with a question of a regex" do
          @parser.parse("foo -> /foo/?;").should_not be_nil
        end

        it "should allow a repeated expression with a + for repetition" do
          @parser.parse("foo -> bar+;").should_not be_nil
        end

        it "should allow an optionally repeated expression with a '*'" do
          @parser.parse("foo -> bar*;").should_not be_nil
        end
      end
    end
  end
end
