module Antelope
  module IR
    class OptionalExpression < Base
      def initialize(expression)
        @expression = expression
      end

      attr_reader :expression
    end
  end
end
