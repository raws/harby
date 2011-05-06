require "test_helper"

module Harby
  class ArrayParserTest < ParserTestCase
    test "an array argument with naked strings" do
      assert_parsed "(foo)", [["foo"]]
      assert_parsed "(foo bar baz)", [["foo", "bar", "baz"]]
    end
  end
end
