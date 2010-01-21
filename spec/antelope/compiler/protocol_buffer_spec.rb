require "spec_helper"

module Antelope
  describe "serializing to protocol buffers" do
    before do
      @grammar = IR::Grammar.new
      @grammar.name = "Foo"
      @grammar.rules << IR::Rule.new
      @rule = @grammar.rules.first
    end

    it "should serialize a grammar with one rule" do
      Compiler.compile(@grammar).should be_a_kind_of(Compiler::ProtocolBuffer)
    end

    it "should have the grammar name" do
      Compiler.compile(@grammar).grammar.name.should == "Foo"
    end

    it "should use the correct grammar name" do
      @grammar.name = "bar"
      Compiler.compile(@grammar).grammar.name.should == "bar"
    end

    it "should have the first rule as the start rule" do
      @grammar.rules.first.name = "foo"

      protobuf = Compiler.compile(@grammar)
      protobuf.grammar.start_rule_name.should == "foo"
    end

    it "should use the correct name for the start rule" do
      @grammar.rules.first.name = "bar"

      protobuf = Compiler.compile(@grammar)
      protobuf.grammar.start_rule_name.should == "bar"
    end

    it "should serialize all of the grammar rules" do
      @grammar.rules << IR::Rule.new

      protobuf = Compiler.compile(@grammar)
      protobuf.grammar.rules.size.should == 2
    end

    describe "serializing a grammar rule" do
      describe "a rule reference" do
        before do
          @rule = IR::Rule.new
          @rule.name = "Foo"
          @grammar.rules.first.productions << @rule
        end

        it "should serialize a rule reference as a an array of one element" do
          protobuf = Compiler.compile(@grammar)
          protobuf.grammar.rules.first.productions.size.should == 1
        end

        it "should have the type of reference" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first

          production.type.should == "reference"
        end

        it "should have a reference to the rule id" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first

          production.identifiers.should == [@rule.hash]
        end
      end

      describe "an or expression" do
        before do
          @rule1 = IR::Rule.new(:name => "foo")
          @rule2 = IR::Rule.new(:name => "bar")
          alternation = IR::Alternation.new(@rule1, @rule2)
          @rule.productions << alternation
        end

        it "should have the type of or" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.type.should == "or"
        end

        it "should have two ids" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.identifiers.should == [@rule1.hash, @rule2.hash]
        end
      end

      describe "a grouped expression A -> (B C)" do
        before do
          @a = IR::Rule.new("A")
          @b = IR::Rule.new("B")
          @c = IR::Rule.new("C")

          @grammar.rules = [@a, @b, @c]

          @grouped_expression = IR::GroupedExpression.new(@b, @c)
          @a.productions = [@grouped_expression]
        end

        it "should have the type of 'and'" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.type.should == "and"
        end

        it "should have a reference to the b rule" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.identifiers.should include(@b.hash)
        end

        it "should have a reference to the c rule" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.identifiers.should include(@c.hash)
        end
      end

      describe "a literal" do
        before do
          @literal = IR::Literal.new
          @literal.text = "foo"

          @rule.productions << @literal
        end

        it "should have the type as a literal" do
          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first
          production.type.should == "literal"
        end

        it "should have the text of the literal" do
          @literal.text = "foo"

          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first

          production.text.should == "foo"
        end

        it "should use the correct text" do
          @literal.text = "bar"

          protobuf = Compiler.compile(@grammar)
          production = protobuf.grammar.rules.first.productions.first

          production.text.should == "bar"
        end
      end
    end
  end
end