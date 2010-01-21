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
        @name        = name
        @productions = []
        self.class.register(self)
      end

      attr_accessor :name
      attr_accessor :productions

      def to_protobuf
        rule = Compiler::ProtocolBuffer::Rule.new
        rule.name = name
        rule.identifier = hash
        productions.each do |production|
          rule.productions << production.protobuf_reference
        end
        rule
      end

      def protobuf_reference
        production = Compiler::ProtocolBuffer::Production.new
        production.type       = "reference"
        production.identifier = hash
        production
      end
    end
  end
end
