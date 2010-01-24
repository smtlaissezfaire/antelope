module Antelope
  module IR
    class Alternation < Base
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives

      def to_json
        super do |rules, nodes|
          nodes << json_node

          alternatives.each do |alternative|
            children_rules, children_nodes = alternative.to_json

            rules.concat(children_rules)
            nodes.concat(children_nodes)
          end
        end
      end

    private

      def type_name
        ALTERNATION
      end
    end
  end
end
