module Antelope
  module IR
    class OptionalExpression < Base
      def initialize(expression)
        @expression = expression
      end

      attr_reader :expression

      def protobuf_reference
        super do |production|
          production.identifiers << expression.hash
        end
      end

    private

      def type_name
        NodeTypes::OPTIONAL_EXPRESSION
      end
    end
  end
end
