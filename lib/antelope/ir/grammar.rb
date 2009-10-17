module Antelope
  module IR
    class Grammar
      attr_reader :start_symbol
      
      def start_symbol=(sym_or_string)
        @start_symbol = sym_or_string.respond_to?(:to_sym) ? sym_or_string.to_sym : sym_or_string
      end
      
      def compilable?
        start_symbol && start_symbol_valid? && rules.any?
      end
      
      def rules
        @rules ||= []
      end
      
      attr_writer :rules
      
    private
    
      def start_symbol_valid?
        rules.any? { |r| r.name == start_symbol }
      end
    end
  end
end