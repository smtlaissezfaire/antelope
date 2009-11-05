require "using"

module Antelope
  extend Using
  
  using :IR, :file => "ir"
  using :Parser
  using :Version
end