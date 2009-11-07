module Antelope
  module IR
    class Alternation
      def initialize(*alternatives)
        raise ArgumentError, 'Must have two or more alternaties' if alternatives.size < 2
        @alternatives = alternatives
      end

      attr_reader :alternatives
    end
  end
end
