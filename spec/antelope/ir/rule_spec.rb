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

      describe "find_or_create_by_name" do
        before do
          Rule.clear_instances!
        end

        it "should create a new one" do
          r = Rule.find_or_create_by_name("foo")
          r.should be_a_kind_of(Rule)
        end

        it "should create a new one with the name" do
          r = Rule.find_or_create_by_name("foo")
          r.name.should == "foo"
        end

        it "should create a new one with the correct name" do
          r = Rule.find_or_create_by_name("bar")
          r.name.should == "bar"
        end

        it "should find an existing one with the name" do
          r1 = Rule.new
          r1.name = "foo"

          r2 = Rule.find_or_create_by_name("foo")

          r2.should equal(r1)
        end
      end
    end
  end
end
