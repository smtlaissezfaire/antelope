module Antelope
  module IR
    class Literal < Base
      attr_accessor :text

      def protobuf_reference
        super do |production|
          production.text = text
        end
      end

    private

      def type_name
        ProductionTypes::LITERAL
      end
    end
  end
end
