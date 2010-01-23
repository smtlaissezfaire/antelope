module Antelope
  module IR
    class Literal < Base
      attr_accessor :text

      def to_protobuf
        super do |_, nodes|
          nodes << protobuf_node
        end
      end

      def protobuf_node
        super do |node|
          node.text = text
        end
      end

    private

      def type_name
        NodeTypes::LITERAL
      end
    end
  end
end
