module Antelope
  module IR
    class Base
      NodeTypes = Compiler::ProtocolBuffer::NodeTypes

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Node.new

        production.type = type_name
        yield production if block_given?

        production
      end
    end
  end
end