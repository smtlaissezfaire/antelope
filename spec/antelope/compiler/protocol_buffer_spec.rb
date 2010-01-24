require "spec_helper"

module Antelope
  describe Compiler do
    describe "serializing to protocol buffers" do
      before do
        @grammar = IR::Grammar.new
        @grammar.name = "Foo"
      end

      def protocol_buffer
        Compiler.to_json(@grammar)
      end

      def protocol_buffer_rules
        protocol_buffer.rules
      end

      def protocol_buffer_nodes
        protocol_buffer.nodes
      end

      describe "serializing the grammar" do
        it "should set the grammar name" do
          protocol_buffer.name.should == @grammar.name
        end

        it "should have a reference to the start rule" do
          protocol_buffer.start_rule.should == @grammar.start_rule.hash
        end
      end

      describe "serializing a grammar rule" do
        before do
          @rule = IR::Rule.new("first_rule")
          @grammar.rules << @rule
        end

        it "should add a rule to the grammar" do
          rules = protocol_buffer_rules
          rules.size.should == 1
        end

        it "should add a node to the grammar" do
          nodes = protocol_buffer_nodes
          nodes.size.should == 1
        end

        describe "the rule" do
          before do
            @grammar_rule = protocol_buffer_rules.first
          end

          it "should store the identifier" do
            @grammar_rule.identifier.should == @rule.hash
          end

          it "should have a name" do
            @grammar_rule.name.should == @rule.name
          end
        end

        describe "the node" do
          before do
            @node = protocol_buffer_nodes.first
          end

          it "should have an empty list of references" do
            @node.references.should == []
          end

          it "should have the reference identifier" do
            @node.identifier.should == @rule.hash
          end

          it "should have the reference type" do
            @node.type.should == Compiler::EncodedGrammar::RULE
          end
        end
      end

      describe "serializing A -> B" do
        before do
          @rule_a = IR::Rule.new("A")
          @rule_b = IR::Rule.new("B")

          @rule_a.productions << @rule_b

          @grammar.rules << @rule_a

          @grammar.start_symbol = "A"
        end

        it "should have two grammar rules" do
          protocol_buffer_rules.size.should == 2
        end

        it "should have two nodes" do
          protocol_buffer_nodes.size.should == 2
        end

        describe "the parent node" do
          it "should have a reference to the child node" do
            parent = protocol_buffer_nodes.first
            child  = protocol_buffer_nodes.last

            parent.references.should == [child.identifier]
          end
        end

        describe "the child node" do
          before do
            @child_node = protocol_buffer_nodes.last
          end

          it "should have no references" do
            @child_node.references.should == []
          end

          it "should have type = RULE" do
            @child_node.type.should == Compiler::EncodedGrammar::RULE
          end

          it "should have the id" do
            @child_node.identifier.should == @rule_b.hash
          end
        end
      end

      describe "serializing A | B" do
        before do
          @rule_a = IR::Rule.new("A")
          @rule_b = IR::Rule.new("B")
          @parent = IR::Alternation.new(@rule_a, @rule_b)
          @start_rule = IR::Rule.new("start_rule")
          @start_rule.productions << @parent

          @grammar.rules << @start_rule
          @grammar.start_symbol = "start_rule"
        end

        it "should have 3 rules - the start rule and the two children" do
          protocol_buffer_rules.size.should == 3
        end

        it "should have 4 nodes - the start rule, the OR, and the children" do
          protocol_buffer_nodes.size.should == 4
        end

        describe "the node" do
          def node
            protocol_buffer_nodes.detect do |node|
              node.type == Compiler::EncodedGrammar::ALTERNATION
            end
          end

          it "should have the correct type" do
            node.type.should == Compiler::EncodedGrammar::ALTERNATION
          end

          it "should have the identifier" do
            node.identifier.should == @parent.hash
          end
        end
      end

      describe "a literal A -> 'some_text'" do
        before do
          @rule = IR::Rule.new
          @grammar.rules << @rule

          @literal = IR::Literal.new
          @literal.text = "foo"

          @rule.productions << @literal
        end

        it "should have two nodes - the first rule, and the literal" do
          protocol_buffer_nodes.size.should == 2
        end

        it "should have one rule" do
          protocol_buffer_rules.size.should == 1
        end

        describe "the node" do
          before do
            @node = protocol_buffer_nodes.last
          end

          it "should have the type as a literal" do
            @node.type.should == Compiler::EncodedGrammar::LITERAL
          end

          it "should have the text of the literal" do
            @node.text.should == "foo"
          end

          it "should use the id" do
            @node.identifier.should == @literal.hash
          end
        end
      end

      describe "an optional expression A -> B?" do
        before do
          @rule_a = IR::Rule.new("A")
          @rule_b = IR::Rule.new("B")
          @optional_expression = IR::OptionalExpression.new(@rule_b)

          @rule_a.productions << @optional_expression

          @grammar.rules << @rule_a
        end

        it "should have two grammar rules" do
          protocol_buffer_rules.size.should == 2
        end

        it "should have three nodes" do
          protocol_buffer_nodes.size.should == 3
        end
      end

      describe "an optional repetition: A -> B*" do
        before do
          @rule_a = IR::Rule.new("A")
          @rule_b = IR::Rule.new("B")
          @optional_repetition = IR::OptionalRepetition.new(@rule_b)

          @rule_a.productions << @optional_repetition

          @grammar.rules << @rule_a
        end

        it "should have two grammar rules" do
          protocol_buffer_rules.size.should == 2
        end

        it "should have three nodes" do
          protocol_buffer_nodes.size.should == 3
        end
      end

      describe "a repetition: A -> B+" do
        before do
          @rule_a = IR::Rule.new("A")
          @rule_b = IR::Rule.new("B")
          @repetition = IR::Repetition.new(@rule_b)

          @rule_a.productions << @repetition
          @grammar.rules << @rule_a
        end

        it "should have two grammar rules" do
          protocol_buffer_rules.size.should == 2
        end

        it "should have three nodes" do
          protocol_buffer_nodes.size.should == 3
        end
      end

      describe "a grouped expression A -> (B C)" do
        before do
          @a = IR::Rule.new("A")
          @b = IR::Rule.new("B")
          @c = IR::Rule.new("C")

          @grammar.rules = [@a, @b, @c]

          @grouped_expression = IR::GroupedExpression.new(@b, @c)

          @a.productions << @grouped_expression
        end

        it "should have three grammar rules" do
          protocol_buffer_rules.size.should == 3
        end

        it "should have 4 nodes" do
          protocol_buffer_nodes.size.should == 4
        end
      end
    end
  end
end