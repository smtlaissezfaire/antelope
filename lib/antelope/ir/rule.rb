module Antelope
  module IR
    class Rule
      class << self
        def register(instance)
          instances << instance
        end

        def clear_instances!
          @instances = []
        end

        def find_or_create_by_name(name)
          if instance = instances.detect { |instance| instance.name == name }
            instance
          else
            new(name)
          end
        end

        def instances
          @instances ||= []
        end
      end

      def initialize(name = nil)
        @name = name
        @productions = []
        self.class.register(self)
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
