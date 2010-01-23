module Antelope
  module IR
    class Alternation < Base
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives

      def to_protobuf
        super do |rules, nodes|
          nodes << protobuf_node

          alternatives.each do |alternative|
            children_rules, children_nodes = alternative.to_protobuf

            rules.concat(children_rules)
            nodes.concat(children_nodes)
          end
        end
      end

    private

      def type_name
        NodeTypes::ALTERNATION
      end
    end
  end
end
