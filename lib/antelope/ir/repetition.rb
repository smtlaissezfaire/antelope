module Antelope
  module IR
    class Repetition < Base
      def initialize(first)
        @expression = first
      end

      attr_reader :expression

      def protobuf_reference
        super do |production|
          production.identifiers << expression.hash
        end
      end

    private

      def type_name
        ProductionTypes::REPETITION
      end
    end
  end
end
