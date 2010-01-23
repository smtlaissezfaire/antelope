module Antelope
  module Compiler
    extend Using

    using :ProtocolBuffer, :file => "protocol_buffer.pb.rb"

    def self.to_protocol_buffer(grammar)
      buffer = ProtocolBuffer.new
      buffer.grammar = grammar.to_protobuf
      buffer
    end

    def self.compile(grammar, a_file = nil)
      protobuf = to_protocol_buffer(grammar)

      a_file ?
        protobuf.serialize_to_file(a_file) :
        protobuf.serialize_to_string
    end
  end
end