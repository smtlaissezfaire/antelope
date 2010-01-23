module Antelope
  module IR
    class OptionalRepetition < Repetition

    private

      def type_name
        ProductionTypes::OPTIONAL_REPETITION
      end
    end
  end
end
