require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

module Antelope
  module IR
    describe Grammar do
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
        
        it "should convert a stringified start symbol to a symbol" do
          @grammar.start_symbol = "foo"
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
          @grammar = Grammar.new
        end
        
        it "should not be compilable when instantiated" do
          @grammar.should_not be_compilable
        end
        
        it "should be compilable if it has a start symbol" do
          @grammar.start_symbol = :foo
          @grammar.should be_compilable
        end
      end
    end
  end
end