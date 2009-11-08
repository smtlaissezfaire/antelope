module Antelope
  module IR
    class OptionalRepetition < Repetition
      def initialize(first, *rest)
        @expressions = [first, rest].flatten
      end

      attr_reader :expressions
    end
  end
end
