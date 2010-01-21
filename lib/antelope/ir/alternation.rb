module Antelope
  module IR
    class Alternation < Base
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives

      def protobuf_reference
        super do |production|
          alternatives.map { |alternative| alternative.hash }.each do |id|
            production.identifiers << id
          end
        end
      end

    private

      def type_name
        ProductionTypes::ALTERNATION
      end
    end
  end
end
