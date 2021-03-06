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

      describe "instantiation" do
        it "should instantiate a string" do
          rule = @parser.parse("foo -> 'bar';").eval
          expr = rule.productions.first
          expr.should be_a_kind_of(IR::Literal)
        end

        it "should instantiate a regex" do
          rule = @parser.parse("foo -> /bar/;").eval
          expr = rule.productions.first
          expr.should be_a_kind_of(IR::Regex)
        end

        it "should instantiate a rule" do
          rule = @parser.parse("foo -> bar;").eval
          expr = rule.productions.first
          expr.should be_a_kind_of(IR::Rule)
        end

        it "should use a name for the rule" do
          rule = @parser.parse("foo -> bar;").eval
          expr = rule.productions.first
          expr.name.should == "bar"
        end

        it "should use the correct name for the rule" do
          rule = @parser.parse("foo -> baz;").eval
          expr = rule.productions.first
          expr.name.should == "baz"
        end

        it "should be able to have a rule refer to itself" do
          rule = @parser.parse("foo -> foo;").eval
          rule.productions.first.should equal(rule)
        end

        it "should have multiple rules as multiple productions" do
          rule = @parser.parse("foo -> 'bar' 'baz';").eval
          rule.productions.size.should == 2
        end

        it "should allow 3 expressions" do
          rule = @parser.parse("foo -> 'bar' 'baz' 'quxx';").eval
          rule.productions.size.should == 3
        end

        it "should have an or expression as one production" do
          rule = @parser.parse("foo -> 'bar' | 'baz';").eval
          rule.productions.size.should == 1
        end

        it "should create an IR::Alternation from an OR expression" do
          rule = @parser.parse("foo -> 'bar' | 'baz';").eval
          alternation = rule.productions.first

          alternation.should be_a_kind_of(IR::Alternation)
        end

        it "should have the first alternative" do
          rule = @parser.parse("foo -> 'bar' | 'baz';").eval
          alternation = rule.productions.first

          first = alternation.alternatives.first
          first.should be_a_kind_of(IR::Literal)
        end

        it "should have the proper second alternative" do
          rule = @parser.parse("foo -> 'bar' | 'baz';").eval
          alternation = rule.productions.first

          second = alternation.alternatives.last
          second.should be_a_kind_of(IR::Literal)
        end

        it "should allow multiple ORs - with the second as an alternation of the second two values" do
          rule = @parser.parse("foo -> 'bar' | 'baz' | 'quxx';").eval
          alternation = rule.productions.first

          second = alternation.alternatives.last
          second.should be_a_kind_of(IR::Alternation)
          second.alternatives.size.should == 2
        end

        it "should have a parenthesized expression as a grouped expression" do
          rule = @parser.parse("foo -> ('bar');").eval
          expression = rule.productions.first

          expression.should be_a_kind_of(IR::GroupedExpression)
        end

        it "should have the results of the parenthesized expression" do
          rule = @parser.parse("foo -> ('bar');").eval
          expression = rule.productions.first

          expression.expressions.size.should == 1
          result = expression.expressions.first

          result.should be_a_kind_of(IR::Literal)
        end

        it "should parse a question mark as an optional expression" do
          rule = @parser.parse("foo -> 'bar'?;").eval

          expression = rule.productions.first

          expression.should be_a_kind_of(IR::OptionalExpression)
        end

        it "should use the correct value for the optional expression predicate" do
          rule = @parser.parse("foo -> 'bar'?;").eval

          expression = rule.productions.first

          expression.expression.should be_a_kind_of(IR::Literal)
        end

        it "should parse a plus as an repetition" do
          rule = @parser.parse("foo -> 'bar'+;").eval

          expression = rule.productions.first

          expression.should be_a_kind_of(IR::Repetition)
        end

        it "should use the correct value for the plus predicate" do
          rule = @parser.parse("foo -> 'bar'+;").eval

          repetition = rule.productions.first

          repetition.expression.should be_a_kind_of(IR::Literal)
        end

        it "should parse a star as an optional repetition" do
          rule = @parser.parse("foo -> 'bar'*;").eval

          expression = rule.productions.first

          expression.should be_a_kind_of(IR::OptionalRepetition)
        end

        it "should use the correct predicate for the optional repetition" do
          rule = @parser.parse("foo -> 'bar'*;").eval

          expression = rule.productions.first

          expression.expression.should be_a_kind_of(IR::Literal)
        end
      end
    end
  end
end
