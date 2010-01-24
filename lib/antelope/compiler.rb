module Antelope
  module Compiler
    extend Using

    using :EncodedGrammar

    def self.to_json(grammar)
      grammar.to_json
    end

    def self.compile(grammar, a_file = nil)
      json = to_json(grammar)

      a_file ?
        json.serialize_to_file(a_file) :
        json.serialize_to_string
    end
  end
end