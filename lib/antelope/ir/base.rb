module Antelope
  module IR
    class Base
      NodeTypes = Compiler::ProtocolBuffer::NodeTypes

      def to_protobuf
        rules, nodes = [], []
        yield(rules, nodes) if block_given?
        [rules, nodes]
      end

      def protobuf_node
        node = Compiler::ProtocolBuffer::Node.new
        node.identifier = hash
        node.type = type_name
        yield(node) if block_given?
        node
      end

    private

      def add_self_and_children(rules, nodes)
        nodes << protobuf_node

        expression_list.each do |expression|
          children_rules, children_nodes = expression.to_protobuf
          rules.concat(children_rules)
          nodes.concat(children_nodes)
        end
      end

      def expression_list
        if respond_to?(:expression)
          [expression]
        else
          expressions
        end
      end

      # def protobuf_reference(grammar)
      #   production = Compiler::ProtocolBuffer::Node.new
      #
      #   production.type = type_name
      #   yield production if block_given?
      #
      #   production
      # end
    end
  end
end