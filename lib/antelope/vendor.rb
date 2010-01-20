paths = File.join(File.dirname(__FILE__), "vendor", "*", "lib")

Dir.glob(paths).each do |file|
  $LOAD_PATH.unshift file
end