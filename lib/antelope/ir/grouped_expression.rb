module Antelope
  module IR
    class GroupedExpression < Base
      def initialize(*expressions)
        @expressions = expressions
      end

      attr_reader :expressions

      def to_protobuf
        super do |rules, nodes|
          add_self_and_children(rules, nodes)
        end
      end

    private

      def type_name
        NodeTypes::GROUPED_EXPRESSION
      end
    end
  end
end