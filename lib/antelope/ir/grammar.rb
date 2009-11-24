module Antelope
  module IR
    class Grammar
      def initialize
        @rules             = []
        @included_grammars = []
      end

      attr_accessor :name
      attr_accessor :start_symbol
      attr_accessor :rules
      attr_accessor :included_grammars

      def include(grammar_name)
        included_grammars << grammar_name
      end

    private

      def start_symbol_valid?
        rules.any? { |r| r.name == start_symbol }
      end
    end
  end
end
