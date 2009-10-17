module Antelope
  module IR
    class Rule
      def name=(name)
        @name = name.respond_to?(:to_sym) ? name.to_sym : name
      end
      attr_reader :name

      attr_reader :grammar
      
      def grammar=(grammar)
        if grammar.respond_to?(:rules) && !grammar.rules.include?(self)
          grammar.rules << self
        end
        
        @grammar = grammar
      end
      
      def productions
        @productions ||= []
      end
      
      attr_writer :productions
      
      def compilable?
        grammar && name && productions.any?
      end
    end
  end
end