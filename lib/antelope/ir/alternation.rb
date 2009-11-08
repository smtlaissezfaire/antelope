module Antelope
  module IR
    class Alternation
      def initialize(first, second)
        @alternatives = [first, second]
      end

      attr_reader :alternatives
    end
  end
end
