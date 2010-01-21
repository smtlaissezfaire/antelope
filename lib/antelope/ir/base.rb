module Antelope
  module IR
    class Base
      ProductionTypes = Compiler::ProtocolBuffer::ProductionTypes

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Production.new

        production.type = type_name
        yield production if block_given?

        production
      end
    end
  end
end