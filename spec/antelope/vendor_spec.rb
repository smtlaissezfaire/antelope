require "spec_helper"

module Antelope
  describe "vendor" do
    it "should have lib/antelope/vendor/ruby-protobuf/lib on the load path" do
      root_path = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

      path = File.join(root_path, "lib", "antelope", "vendor", "ruby-protobuf", "lib")
      $LOAD_PATH.should include(path)
    end
  end
end