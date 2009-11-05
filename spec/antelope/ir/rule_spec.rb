require "spec_helper"

module Antelope
  module IR
    describe Rule do
      before do
        @grammar = Grammar.new
        @rule    = Rule.new
      end
      
      it "should have a name" do
        @rule.name = :foo
        @rule.name.should equal(:foo)
      end
      
      it "should belong to a grammar" do
        @rule.grammar = @grammar
        @rule.grammar.should equal(@grammar)
      end
      
      it "should back-associate the grammar with the rule" do
        @rule.grammar = @grammar
        @rule.grammar.rules.should == [@rule]
      end
      
      describe "productions / right hand sides" do
        it "should have no productions initially" do
          @rule.productions.should == []
        end
        
        it "should be able to add another rule as a production" do
          other_rule = Rule.new
          
          @rule.productions << [other_rule]
          
          @rule.productions.should == [[other_rule]]
        end
      end
      
      describe "compilable?" do
        before do
          @rule = new_compilable_rule
        end
        
        def new_compilable_rule
          grammar = Grammar.new
          rule = Rule.new
          rule.grammar = grammar
          rule.name = "foo"
          rule.productions = [[Rule.new]]
          rule
        end
        
        it "should be true with productions, a name, and belonging to a grammar" do
          @rule.should be_compilable
        end
        
        it "should be false if it doesn't belong to a grammar" do
          @rule.grammar = nil
          @rule.should_not be_compilable
        end
        
        it "should be false if it has no productions" do
          @rule.productions = []
          @rule.should_not be_compilable
        end
        
        it "should be false if it has no name" do
          @rule.name = nil
          @rule.should_not be_compilable
        end
      end
    end
  end
end