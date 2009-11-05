module Antelope
  module IR
    class Grammar
      def initialize
        @rules = []
      end

      attr_accessor :start_symbol
      attr_accessor :rules

      def compilable?
        start_symbol && start_symbol_valid? && rules.any?
      end
      
    private
    
      def start_symbol_valid?
        rules.any? { |r| r.name == start_symbol }
      end
    end
  end
end