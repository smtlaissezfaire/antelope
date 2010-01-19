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

      describe "inclusions" do
        before do
          @grammar = Grammar.new
        end

        it "should include 0 other grammars by default" do
          @grammar.included_grammars.should == []
        end

        it "should be able to include a grammar" do
          @grammar.include "Foo"
          @grammar.included_grammars.should == ["Foo"]
        end

        it "should be able to include several grammars" do
          @grammar.include "Foo"
          @grammar.include "Bar"

          @grammar.included_grammars.should == ["Foo", "Bar"]
        end
      end

      describe "start rule" do
        before do
          @grammar = Grammar.new
        end

        it "should be the start symbol if there is a rule by that name" do
          rule = Rule.new("foo")

          @grammar.rules << rule
          @grammar.start_symbol = "foo"
          @grammar.start_rule.should == rule
        end

        it "should be the first rule if no start symbol is around" do
          rule = Rule.new("foo")

          @grammar.rules << rule
          @grammar.start_symbol = nil
          @grammar.start_rule.should == rule
        end

        it "should be nil if no start symbol & no rules" do
          @grammar.rules = []
          @grammar.start_rule.should be_nil
        end
      end
    end
  end
end
