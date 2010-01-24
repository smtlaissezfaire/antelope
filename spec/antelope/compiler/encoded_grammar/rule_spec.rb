require "spec_helper"

module Antelope
  module Compiler
    describe EncodedGrammar::Rule do
      before do
        @rule = EncodedGrammar::Rule.new
      end

      describe "accessors" do
        [:identifier, :name].each do |attr|
          it "should be able to read + write from the attr #{attr}" do
            @rule.send("#{attr}=", "a value")
            @rule.send(attr).should == "a value"
          end
        end
      end

      describe "to_hash" do
        it "should have the id & name" do
          @rule.identifier = 1234
          @rule.name = "foo"

          @rule.to_hash.should == {
            :identifier => 1234,
            :name => "foo"
          }
        end
      end
    end
  end
end