module Antelope
  module IR
    class Repetition
      def initialize(first, *rest)
        @expressions = [first, rest].flatten
      end

      attr_reader :expressions
    end
  end
end