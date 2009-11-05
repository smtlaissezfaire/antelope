module Antelope
  module Parser
    module Instantiators
      class Base < Treetop::Runtime::SyntaxNode
        def eval
        end
      end
      
      class Grammar < Base
        def eval
          grammar = IR::Grammar.new
          grammar.name = grammar_name.eval
          grammar.rules = grammar_rules.eval
          grammar
        end
      end
      
      class GrammarName < Base
        def eval
          grammar_identifier.text_value
        end
      end
      
      class Rules < Base
        def eval
          elements.map do |e|
            e.eval
          end
        end
      end
      
      class Rule < Base
        def eval
          rule = IR::Rule.new
          rule.name = rule_name.text_value
          rule
        end
      end
    end
  end
end