module Antelope
  module IR
    class Literal < Base
      attr_accessor :text

      def to_json
        super do |_, nodes|
          nodes << json_node
        end
      end

      def json_node
        super do |node|
          node.text = text
        end
      end

    private

      def type_name
        LITERAL
      end
    end
  end
end
