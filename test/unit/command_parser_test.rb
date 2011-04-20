require "test_helper"

module Harby
  class CommandParserTest < ParserTestCase
    test "a command argument" do
      assert_parsed "[foo bar] baz", [{:name => "foo", :args => ["bar"]}, "baz"]
    end
  end
end
