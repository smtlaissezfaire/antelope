module Antelope
  module IR
    class Repetition < Base
      def initialize(first)
        @expression = first
      end

      attr_reader :expression

      def to_protobuf
        super do |rules, nodes|
          add_self_and_children(rules, nodes)
        end
      end

    private

      def type_name
        NodeTypes::REPETITION
      end
    end
  end
end
