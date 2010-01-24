module Antelope
  module IR
    class Rule < Base
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
        @name        = name
        @productions = []
        self.class.register(self)
      end

      attr_accessor :name
      attr_accessor :productions

      def to_json
        rules = [json_rule]
        nodes = [my_node = json_node]

        productions.each do |production|
          children_rules, children_nodes = production.to_json

          children_rules.each do |child_rule|
            my_node.references << child_rule.identifier
          end

          rules.concat(children_rules)
          nodes.concat(children_nodes)
        end

        [rules, nodes]
      end

      def json_rule
        rule = Compiler::EncodedGrammar::Rule.new
        rule.name = name
        rule.identifier = hash
        rule
      end

    private

      def type_name
        RULE
      end
    end
  end
end
