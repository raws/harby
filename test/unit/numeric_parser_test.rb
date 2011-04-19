require "test_helper"

module Harby
  class NumericParserTest < ParserTestCase
    test "a float argument" do
      assert_parsed "12.3", [12.3]
      assert_parsed "+12.3", [12.3]
      assert_parsed "-12.3", [-12.3]
      assert_parsed "0.0", [0.0]
    end
    
    test "an invalid float argument" do
      assert_parsed "--12.3", ["--12.3"]
      assert_parsed "++12.3", ["++12.3"]
    end
    
    test "multiple float arguments" do
      assert_parsed "12.3 4.56", [12.3, 4.56]
      assert_parsed "-12.3 4.56", [-12.3, 4.56]
      assert_parsed "12.3 -4.56", [12.3, -4.56]
      assert_parsed "+12.3 4.56", [12.3, 4.56]
      assert_parsed "12.3 +4.56", [12.3, 4.56]
      assert_parsed "-12.3 +4.56", [-12.3, 4.56]
    end
    
    test "an integer argument" do
      assert_parsed "123", [123]
      assert_parsed "-123", [-123]
      assert_parsed "+123", [123]
      assert_parsed "0", [0]
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
    
    test "mixed numeric arguments" do
      assert_parsed "123 4.56", [123, 4.56]
      assert_parsed "12.3 456", [12.3, 456]
      assert_parsed "-12.3 +456", [-12.3, 456]
      assert_parsed "1 23.4 5", [1, 23.4, 5]
    end
  end
end
