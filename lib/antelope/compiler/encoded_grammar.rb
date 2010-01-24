require 'json'

module Antelope
  module Compiler
    class EncodedGrammar
      module NodeTypes
        NODE_TYPES = [
          RULE                = 1,
          LITERAL             = 2,
          ALTERNATION         = 3,
          GROUPED_EXPRESSION  = 4,
          OPTIONAL_EXPRESSION = 5,
          OPTIONAL_REPETITION = 6,
          REPETITION          = 7
        ]
      end

      include NodeTypes

      def initialize
        @rules = []
        @nodes = []
      end

      attr_accessor :name, :start_rule, :rules, :nodes

      def to_hash
        {
          :name => name,
          :start_rule => start_rule,
          :rules => rules.map { |rule| rule.to_hash },
          :nodes => nodes.map { |node| node.to_hash }
        }
      end

      def to_json
        JSON.generate(to_hash)
      end

      class Node
        def initialize
          @references = []
          @text = ""
        end

        attr_accessor :identifier, :type, :references, :text

        def to_hash
          hash = {
            :identifier => identifier,
            :type => type
          }

          hash[:references] = references
          hash[:text]       = text
          hash
        end
      end

      class Rule
        attr_accessor :identifier, :name

        def to_hash
          { :identifier => identifier, :name => name }
        end
      end
    end
  end
end