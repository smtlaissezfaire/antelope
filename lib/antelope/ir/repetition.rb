module Antelope
  module IR
    class Repetition < Base
      def initialize(first)
        @expression = first
      end

      attr_reader :expression
    end
  end
end
