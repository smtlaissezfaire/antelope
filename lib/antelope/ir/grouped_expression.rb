module Antelope
  module IR
    class GroupedExpression < Base
      def initialize(*expressions)
        @expressions = expressions
      end

      attr_reader :expressions

      def protobuf_reference
        super do |production|
          production.type        = "and"
          expressions.each do |expression|
            production.identifiers << expression.hash
          end
        end
      end
    end
  end
end