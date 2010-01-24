require "spec_helper"

module Antelope
  describe Compiler do
    before do
      @grammar = mock 'grammar'
      @json = mock 'json'
      Compiler.stub!(:to_json).and_return @json
    end

    describe "compiling a grammar to a string" do
      before do
        @json.stub!(:serialize_to_string).and_return "serialized_string"
      end

      it "should compile the grammar to a protocol buffer" do
        Compiler.should_receive(:to_json).and_return @json
        Compiler.compile(@grammar)
      end

      it "should output a string for the protocol buffer" do
        @json.should_receive(:serialize_to_string).and_return "serialized_string"
        Compiler.compile(@grammar).should == "serialized_string"
      end
    end

    describe "compiling a grammar to a file" do
      before do
        @json.stub!(:serialize_to_file)
      end

      it "should serialize the protocol buffer" do
        Compiler.should_receive(:to_json).and_return @json
        Compiler.compile(@grammar, "a_file")
      end

      it "should serialize the protocol buffer to a file" do
        @json.should_receive(:serialize_to_file).with("a_file")
        Compiler.compile(@grammar, "a_file")
      end
    end
  end
end