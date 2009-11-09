module Antelope
  module IR
    class GroupedExpression
      def initialize(expressions)
        @expressions = expressions
      end

      attr_reader :expressions
    end
  end
end