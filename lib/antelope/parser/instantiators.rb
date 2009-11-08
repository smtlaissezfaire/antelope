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
          grammar.name  = grammar_declaration.eval
          grammar.rules = zero_or_more_grammar_rules.eval
          grammar
        end
      end

      class GrammarDeclaration < Base
        def eval
          grammar_identifier.text_value
        end
      end

      class EmptyGrammarRuleList < Base
        def eval
          []
        end
      end

      class OneOrMoreGrammarRules < Base
        def eval
          grammar_rules.eval
        end
      end

      module MultipleRules
        def eval
          car + cdr
        end

        def car
          [head.eval]
        end

        # (SP+ grammar_rules)* =>
        # [[SP+ [rule , [SP+, grammar_rule]]]]
        def cdr
          if car = tail.elements.first
            car.eval
          else
            []
          end
        end
      end

      class RuleBody < Base
        def eval
          sequence.eval
        end
      end

      class Sequence < Base
        def eval
          node.eval
        end
      end

      class Rule < Base
        def eval
          rule = IR::Rule.new
          rule.name = rule_name.text_value
          rule.productions = [rule_body.eval]
          rule
        end
      end

      class Regex < Base
        def eval
          regex = IR::Regex.new
          regex.text = text.text_value
          regex
        end
      end

      class Literal < Base
        def eval
          lit = IR::Literal.new
          lit.text = text.text_value
          lit
        end
      end
    end
  end
end
