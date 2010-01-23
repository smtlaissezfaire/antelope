module Antelope
  module IR
    class OptionalRepetition < Repetition
      def initialize(first, *rest)
        @expressions = [first, rest].flatten
      end

      attr_reader :expressions

      def protobuf_reference
        super do |production|
          production.identifiers << expressions.first.hash
        end
      end

    private

      def type_name
        ProductionTypes::OPTIONAL_REPETITION
      end
    end
  end
end
