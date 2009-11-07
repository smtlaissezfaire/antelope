module Antelope
  module IR
    class Rule
      def initialize
        @productions = []
      end

      attr_accessor :name
      attr_accessor :productions
      attr_reader   :grammar

      def grammar=(grammar)
        if grammar.respond_to?(:rules) && !grammar.rules.include?(self)
          grammar.rules << self
        end

        @grammar = grammar
      end

      def compilable?
        grammar && name && productions.any?
      end
    end
  end
end
