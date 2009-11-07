module Antelope
  module Parser
    extend Using

    require 'treetop'
    Treetop.load File.dirname(__FILE__) + "/parser/treetop_parser.treetop"
    using :Instantiators
  end
end
