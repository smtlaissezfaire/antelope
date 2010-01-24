require "spec_helper"

module Antelope
  module Compiler
    describe EncodedGrammar do
      before do
        @grammar = EncodedGrammar.new
      end

      it "should have an empty list of rules" do
        @grammar.rules.should == []
      end

      it "should have an empty list of nodes" do
        @grammar.nodes.should == []
      end

      describe "to_hash" do
        it "should have a name" do
          @grammar.name = "Foo"
          @grammar.to_hash[:name] == "Foo"
        end

        it "should have a start rule" do
          @grammar.start_rule = 1234
          @grammar.to_hash[:start_rule].should == 1234
        end

        it "should encode the rules" do
          rule = EncodedGrammar::Rule.new
          @grammar.rules << rule

          @grammar.to_hash[:rules].should == [rule.to_hash]
        end

        it "should encode the nodes" do
          node = EncodedGrammar::Node.new
          @grammar.nodes << node

          @grammar.to_hash[:nodes].should == [node.to_hash]
        end
      end

      describe "to_json" do
        it "should turn the grammar hash into a json string" do
          @grammar.to_json.should == JSON.generate(@grammar.to_hash)
        end
      end
    end
  end
end