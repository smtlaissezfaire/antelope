module Antelope
  module IR
    class Literal < Base
      attr_accessor :text

      def protobuf_reference
        super do |production|
          production.type = "literal"
          production.text = text
        end
      end
    end
  end
end
