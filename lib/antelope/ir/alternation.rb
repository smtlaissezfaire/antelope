module Antelope
  module IR
    class Alternation
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Production.new
        production.type = "or"
        alternatives.map { |alternative| alternative.hash }.each do |id|
          production.identifiers << id
        end
        production
      end
    end
  end
end
