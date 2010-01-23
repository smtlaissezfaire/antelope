module Antelope
  module IR
    class Alternation < Base
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives

      def protobuf_reference
        super do |production|
          alternatives.each do |alternative|
            production.identifiers << alternative.hash
          end
        end
      end

    private

      def type_name
        NodeTypes::ALTERNATION
      end
    end
  end
end
