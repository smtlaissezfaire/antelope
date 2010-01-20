module Antelope
  module Compiler
    extend Using

    using :ProtocolBuffer, :file => "protocol_buffer.pb.rb"

    def self.compile(grammar)
      buffer = ProtocolBuffer.new
      buffer.grammar = grammar.to_protobuf
      buffer
    end
  end
end