require "spec_helper"

module Antelope
  module Parser
    describe GrammarParser do
      before do
        @parser = GrammarParser.new
      end

      describe "grammar" do
        it "should be able to set a grammar name" do
          @parser.parse("grammar Foo;").should_not be_nil
        end

        it "should not parse gobbledygook" do
          @parser.parse("adfadsfadlkzcjvlads;").should be_nil
        end

        it "should parse any named grammar" do
          @parser.parse("grammar my_grammar;").should_not be_nil
        end

        it "should return a grammar object" do
          result = @parser.parse("grammar Foo;").eval
          result.should be_a_kind_of(Antelope::IR::Grammar)
        end

        it "should use the grammar name" do
          grammar = @parser.parse("grammar Foo;").eval
          grammar.name.should == "Foo"
        end

        it "shoulse use the correct name" do
          grammar = @parser.parse("grammar Bar;").eval
          grammar.name.should == "Bar"
        end

        it "should be able to parse a rule with an empty string after a grammar name" do
          @parser.parse("grammar Foo;\nfoo->'';").should_not be_nil
        end

        it "should allow multiple grammar rules, separated by newlines" do
          @parser.parse("grammar Foo;\nfoo->'';\nfoo->'';").should_not be_nil
        end

        it "should allow the rule to be named a different string" do
          @parser.parse("grammar Foo;\nbar->'';").should_not be_nil
        end

        it "should allow space between the rule and the definition" do
          @parser.parse("grammar Foo;\nbar    ->     '';").should_not be_nil
        end

        it "should allow multiple newlines between a definition" do
          @parser.parse("grammar Foo;\n\n\nfoo->'';").should_not be_nil
        end

        it "should allow multiple semicolons between rules" do
          @parser.parse("grammar Foo;;;;;;;;;;;;;foo->'';").should be_nil
        end

        it "should not allow a grammar / rule to next to each other with no semicolon" do
          @parser.parse("grammar Foo\n\n\nfoo->'bar';").should be_nil
        end

        it "should allow any number of spaces at the end of grammar (after the grammar declaration)" do
          @parser.parse("grammar Foo;            ").should_not be_nil
        end

        it "should allow any number of spaces at the end of grammar (after a rule declaration)" do
          @parser.parse("grammar Foo; bar -> 'baz';              ").should_not be_nil
        end
      end

      describe "rule names, rules" do
        it "should report zero rules when none given" do
          grammar = @parser.parse("grammar Foo;").eval
          grammar.rules.should be_empty
        end

        it "should have one rule when one is given" do
          grammar = @parser.parse("grammar Foo;foo->'';").eval
          grammar.rules.size.should == 1
        end

        it "should set two rules when two are given" do
          grammar = @parser.parse("grammar Foo;foo->'';bar->'';").eval
          grammar.rules.size.should == 2
        end

        it "should set three rules when three are given" do
          grammar = @parser.parse("grammar Foo;foo->'';bar->'';baz->'';").eval
          grammar.rules.size.should == 3
        end

        it "should have a rule as a Rule object" do
          grammar = @parser.parse("grammar Foo;foo->'';").eval
          grammar.rules.first.should be_a_kind_of(IR::Rule)
        end

        it "should give the rule a name" do
          grammar = @parser.parse("grammar Foo;foo->'';").eval
          rule = grammar.rules.first
          rule.name.should == "foo"
        end

        it "should use the correct name" do
          grammar = @parser.parse("grammar Foo;bar->'';").eval
          rule = grammar.rules.first
          rule.name.should == "bar"
        end
      end

      describe "literal strings" do
        it "should allow any literal inside single quotes" do
          @parser.parse("grammar Foo;bar->'foo';").should_not be_nil
        end

        it "should allow a literal to be a string quoted with double quote" do
          @parser.parse("grammar Foo;bar->\"foo\";").should_not be_nil
        end

        it "should allow any double quoted literal" do
          @parser.parse("grammar Foo;bar->\"baradsfad adfa d\";").should_not be_nil
          @parser.parse("grammar Foo;bar->\"\";").should_not be_nil
        end

        it "should create a rule with a production" do
          grammar = @parser.parse("grammar Foo;bar->'baz';").eval
          rule    = grammar.rules.first
          rule.productions.size.should == 1
        end

        it "should have the production as a literal" do
          grammar    = @parser.parse("grammar Foo;bar->'baz';").eval
          rule       = grammar.rules.first
          production = rule.productions.first

          production.should be_a_kind_of(IR::Literal)
        end

        it "should use the text in the literal" do
          grammar = @parser.parse("grammar Foo;bar->'foo';").eval
          rule    = grammar.rules.first
          literal = rule.productions.first

          literal.text.should == "foo"
        end

        it "should use the correct text" do
          grammar = @parser.parse("grammar Foo;bar->'bar';").eval
          rule    = grammar.rules.first
          literal = rule.productions.first

          literal.text.should == "bar"
        end

        it "should use the text in the literal for a double quoted literal" do
          grammar = @parser.parse("grammar Foo;bar->\"foo\";").eval
          rule    = grammar.rules.first
          literal = rule.productions.first

          literal.text.should == "foo"
        end
      end

      describe "regexs" do
        it "should be able to parse a regex" do
          @parser.parse("grammar Foo;bar->/foo/;").should_not be_nil
        end

        it "should parse any regex given" do
          @parser.parse("grammar Foo;bar->/adfasdf/;").should_not be_nil
        end

        it "should parse a regex with an escaped delimiter" do
          @parser.parse("grammar Foo;bar->/\\/f/;").should_not be_nil
        end

        it "should return a regex" do
          grammar = @parser.parse("grammar Foo;bar->/foo/;").eval
          rule    = grammar.rules.first
          regex   = rule.productions.first

          regex.should be_a_kind_of(IR::Regex)
        end

        it "should have the text in the regex" do
          grammar = @parser.parse("grammar Foo;bar->/foo/;").eval
          rule    = grammar.rules.first
          regex   = rule.productions.first

          regex.text.should == "foo"
        end

        it "should have the text in the regex" do
          grammar = @parser.parse("grammar Foo;bar->/bar/;").eval
          rule    = grammar.rules.first
          regex   = rule.productions.first

          regex.text.should == "bar"
        end
      end
    end
  end
end
