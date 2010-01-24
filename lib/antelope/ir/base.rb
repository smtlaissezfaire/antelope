module Antelope
  module IR
    class Base
      include Compiler::EncodedGrammar::NodeTypes

      def to_json
        rules, nodes = [], []
        yield(rules, nodes) if block_given?
        [rules, nodes]
      end

      def json_node
        node = Compiler::EncodedGrammar::Node.new
        node.identifier = hash
        node.type = type_name
        yield(node) if block_given?
        node
      end

    private

      def add_self_and_children(rules, nodes)
        nodes << json_node

        expression_list.each do |expression|
          children_rules, children_nodes = expression.to_json
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

      # def json_reference(grammar)
      #   production = Compiler::EncodedGrammar::Node.new
      #
      #   production.type = type_name
      #   yield production if block_given?
      #
      #   production
      # end
    end
  end
end