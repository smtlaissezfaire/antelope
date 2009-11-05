require "spec_helper"

module Antelope
  module Parser
    describe GrammarParser do
      before do
        @parser = GrammarParser.new
      end
      
      it "should be able to set a grammar name" do
        @parser.parse("grammar Foo").should_not be_nil
      end
      
      it "should not parse gobbledygook" do
        @parser.parse("adfadsfadlkzcjvlads").should be_nil
      end
      
      it "should parse any named grammar" do
        @parser.parse("grammar my_grammar").should_not be_nil
      end
      
      it "should return a grammar object" do
        result = @parser.parse("grammar Foo").eval
        result.should be_a_kind_of(Antelope::IR::Grammar)
      end
      
      it "should use the grammar name" do
        grammar = @parser.parse("grammar Foo").eval
        grammar.name.should == "Foo"
      end
      
      it "shoulse use the correct name" do
        grammar = @parser.parse("grammar Bar").eval
        grammar.name.should == "Bar"
      end
      
      it "should be able to parse a rule with an empty string after a grammar name" do
        @parser.parse("grammar Foo\nfoo->''").should_not be_nil
      end
      
      it "should allow multiple grammar rules, separated by newlines" do
        @parser.parse("grammar Foo\nfoo->''\nfoo->''").should_not be_nil
      end
      
      it "should allow the rule to be named a different string" do
        @parser.parse("grammar Foo\nbar->''").should_not be_nil
      end
      
      it "should allow space between the rule and the definition" do
        @parser.parse("grammar Foo\nbar    ->     ''").should_not be_nil
      end
      
      it "should allow multiple newlines between a definition" do
        @parser.parse("grammar Foo\n\n\nfoo->''").should_not be_nil
      end
      
      it "should report zero rules when none given" do
        grammar = @parser.parse("grammar Foo").eval
        grammar.rules.should be_empty
      end
      
      it "should have one rule when one is given" do
        grammar = @parser.parse("grammar Foo\nfoo->''").eval
        grammar.rules.size.should == 1
      end
      
      it "should set two rules when two are given" do
        grammar = @parser.parse("grammar Foo\nfoo->''\nfoo->''").eval
        grammar.rules.size.should == 2
      end
      
      it "should have a rule as a Rule object" do
        grammar = @parser.parse("grammar Foo\nfoo->''").eval
        grammar.rules.first.should be_a_kind_of(IR::Rule)
      end
      
      it "should give the rule a name" do
        grammar = @parser.parse("grammar Foo\nfoo->''").eval
        rule = grammar.rules.first
        rule.name.should == "foo"
      end
      
      it "should use the correct name" do
        grammar = @parser.parse("grammar Foo\nbar->''").eval
        rule = grammar.rules.first
        rule.name.should == "bar"
      end
    end
  end
end