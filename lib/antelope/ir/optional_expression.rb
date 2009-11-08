module Antelope
  module IR
    class OptionalExpression
      def initialize(expression)
        @expression = expression
      end

      attr_reader :expression
    end
  end
end
