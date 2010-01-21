### Generated by rprotoc. DO NOT EDIT!
### <proto file: protocol_buffer.proto>
# package antelope.compiler;
# 
# message ProtocolBuffer {
#   message Production {
#     required string type         = 1;
#     repeated int32  identifiers  = 2;
#   }
# 
#   message Rule {
#     required int32      identifier   = 1;
#     required string     name         = 2;
#     repeated Production productions  = 3;
#   }
# 
#   message Grammar {
#     required string name            = 1;
#     required string start_rule_name = 2;
#     repeated Rule   rules           = 3;
#   }
# 
#   required Grammar grammar = 1;
# }
require 'protobuf/message/message'
require 'protobuf/message/enum'
require 'protobuf/message/service'
require 'protobuf/message/extend'

module Antelope
  module Compiler
    class ProtocolBuffer < ::Protobuf::Message
      defined_in __FILE__
      class Production < ::Protobuf::Message
        defined_in __FILE__
        required :string, :type, 1
        repeated :int32, :identifiers, 2
      end
      class Rule < ::Protobuf::Message
        defined_in __FILE__
        required :int32, :identifier, 1
        required :string, :name, 2
        repeated :Production, :productions, 3
      end
      class Grammar < ::Protobuf::Message
        defined_in __FILE__
        required :string, :name, 1
        required :string, :start_rule_name, 2
        repeated :Rule, :rules, 3
      end
      required :Grammar, :grammar, 1
    end
  end
end