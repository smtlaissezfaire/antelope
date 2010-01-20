require File.join(File.dirname(__FILE__), "antelope", "vendor")
require "using"

module Antelope
  extend Using

  Using.default_load_scheme = :autoload

  using :IR, :file => "ir"
  using :Parser
  using :Version
end
