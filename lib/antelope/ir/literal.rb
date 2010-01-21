module Antelope
  module IR
    class Literal
      attr_accessor :text

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Production.new
        production.type = "literal"
        production.text = text
        production
      end
    end
  end
end
