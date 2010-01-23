module Antelope
  module IR
    class OptionalExpression < Base
      def initialize(expression)
        @expression = expression
      end

      attr_reader :expression

      def to_protobuf
        super do |rules, nodes|
          add_self_and_children(rules, nodes)
        end
      end

    private

      def type_name
        NodeTypes::OPTIONAL_EXPRESSION
      end
    end
  end
end
