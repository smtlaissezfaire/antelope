require "spec_helper"

module Antelope
  module IR
    describe Grammar do
      it "should have a name" do
        g = Grammar.new
        g.name = "foo"
        g.name.should == "foo"
      end
      
      describe "start symbol" do
        before do
          @grammar = Grammar.new
        end
        
        it "should have no start symbol initially" do
          @grammar.start_symbol.should be_nil
        end
        
        it "should allow assignment of the start symbol" do
          @grammar.start_symbol = :foo
          @grammar.start_symbol.should equal(:foo)
        end
      end
      
      describe "rules" do
        before do
          @grammar = Grammar.new
          @rule    = Rule.new
        end
        
        it "should have none initially" do
          @grammar.rules.should == []
        end
        
        it "should be able to add a rule" do
          @grammar.rules << @rule
          @grammar.rules.should == [@rule]
        end
      end
      
      describe "compilable?" do
        before do
          @grammar = new_compilable_grammar
        end
        
        def new_compilable_grammar
          rule = Rule.new
          rule.name = :foo
          
          grammar = Grammar.new
          grammar.start_symbol = :foo
          grammar.rules << rule
          grammar
        end
        
        it "should not be compilable when instantiated" do
          Grammar.new.should_not be_compilable
        end
        
        it "should be compilable if it has a start symbol, one or more rules, and the start symbol is one of the rules" do
          @grammar.should be_compilable
        end
        
        it "should not be compilable without a start symbol" do
          @grammar.start_symbol = nil
          @grammar.should_not be_compilable
        end
        
        it "should not be compileable with an empty list of rules" do
          @grammar.rules = []
          @grammar.should_not be_compilable
        end
        
        it "should not be compilable if the start symbol is not one of the rules" do
          @grammar.start_symbol = :non_existent_rule
          @grammar.should_not be_compilable
        end
      end
    end
  end
end