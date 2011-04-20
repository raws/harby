require "test_helper"

module Harby
  class ArgumentsParserTest < ParserTestCase
    test "mixed arguments" do
      assert_parsed "foo 123 bar", ["foo", 123, "bar"]
      assert_parsed "12.3 'foo bar' baz", [12.3, "foo bar", "baz"]
      assert_parsed "5 '5' 5.0 '5.0'", [5, "5", 5.0, "5.0"]
      assert_parsed '"5" 5 "5.0" 5.0', ["5", 5, "5.0", 5.0]
      assert_parsed "5\\ 0 5 5.0 5\\ .\\ 0", ["5 0", 5, 5.0, "5 . 0"]
      assert_parsed "foo [bar 5]", ["foo", {:name => "bar", :args => [5]}]
      assert_parsed "foo [bar 5.0]", ["foo", {:name => "bar", :args => [5.0]}]
      assert_parsed "[foo bar 123 'baz oof']", [{:name => "foo", :args => ["bar", 123, "baz oof"]}]
    end
  end
end
