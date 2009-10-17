module Antelope
  module IR
    class Grammar
      attr_reader :start_symbol
      
      def start_symbol=(sym_or_string)
        @start_symbol = sym_or_string.to_sym
      end
      
      def compilable?
        start_symbol ? true : false
      end
      
      def rules
        @rules ||= []
      end
    end
  end
end