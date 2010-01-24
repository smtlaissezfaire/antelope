module Antelope
  module IR
    class Repetition < Base
      def initialize(first)
        @expression = first
      end

      attr_reader :expression

      def to_json
        super do |rules, nodes|
          add_self_and_children(rules, nodes)
        end
      end

    private

      def type_name
        REPETITION
      end
    end
  end
end
