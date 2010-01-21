module Antelope
  module IR
    class GroupedExpression
      def initialize(*expressions)
        @expressions = expressions
      end

      attr_reader :expressions

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Production.new
        production.type        = "and"
        expressions.each do |expression|
          production.identifiers << expression.hash
        end
        production
      end
    end
  end
end