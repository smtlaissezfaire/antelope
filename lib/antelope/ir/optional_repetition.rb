module Antelope
  module IR
    class OptionalRepetition < Repetition
      def protobuf_reference
        super do |production|
          production.identifiers << expression.hash
        end
      end

    private

      def type_name
        ProductionTypes::OPTIONAL_REPETITION
      end
    end
  end
end
