module Antelope
  module IR
    class Grammar < Base
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

      def start_rule
        rules.detect { |rule| rule.name == start_symbol } || rules.first
      end

      def to_protobuf
        grammar = Compiler::ProtocolBuffer::Grammar.new
        grammar.name = name
        grammar.start_rule_name = start_rule.name
        rules.each do |rule|
          grammar.rules << rule.to_protobuf
        end
        grammar
      end

    private

      def start_symbol_valid?
        start_rule ? true : false
      end
    end
  end
end
