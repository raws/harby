require "test_helper"

module Harby
  class NumericParserTest < ParserTestCase
    test "an integer argument" do
      assert_parsed "123", [123]
      assert_parsed "-123", [-123]
      assert_parsed "+123", [123]
    end
    
    test "an invalid integer argument" do
      assert_parsed "--123", ["--123"]
      assert_parsed "++123", ["++123"]
    end
    
    test "multiple integer arguments" do
      assert_parsed "123 456", [123, 456]
      assert_parsed "123 -456", [123, -456]
      assert_parsed "-123 456", [-123, 456]
      assert_parsed "123 +456", [123, 456]
      assert_parsed "+123 456", [123, 456]
      assert_parsed "-123 +456", [-123, 456]
    end
  end
end
