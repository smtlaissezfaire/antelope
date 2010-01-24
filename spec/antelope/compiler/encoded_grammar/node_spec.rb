require "spec_helper"

module Antelope
  module Compiler
    describe EncodedGrammar::Node do
      before do
        @node = EncodedGrammar::Node.new
      end

      describe "accessors" do
        [:identifier, :type, :references, :text].each do |attr|
          it "should be able to read + write from the attr #{attr}" do
            @node.send("#{attr}=", "a value")
            @node.send(attr).should == "a value"
          end
        end
      end

      describe "to_hash" do
        it "should have the identifier" do
          @node.identifier = 123
          @node.to_hash[:identifier].should == 123
        end

        it "should have the type" do
          @node.type = 1
          @node.to_hash[:type].should == 1
        end

        it "should have an empty list of references if there are none" do
          @node.to_hash[:references].should == []
        end

        it "should have a list of references if provided" do
          @node.references = [1,2,3]
          @node.to_hash[:references].should == [1,2,3]
        end

        it "should have a text value if provided" do
          @node.text = "abc"
          @node.to_hash[:text].should == "abc"
        end
      end
    end
  end
end