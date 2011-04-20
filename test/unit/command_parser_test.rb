require "test_helper"

module Harby
  class CommandParserTest < ParserTestCase
    test "a command argument" do
      assert_parsed "[foo]", [{:name => "foo", :args => []}]
      assert_parsed "[foo bar]", [{:name => "foo", :args => ["bar"]}]
      assert_parsed "[foo\\ bar]", [{:name => "foo bar", :args => []}]
    end
    
    test "nested command arguments" do
      assert_parsed "[foo bar [baz]]", [{:name => "foo", :args => ["bar", {:name => "baz", :args => []}]}]
      assert_parsed "[foo bar [baz oof]]", [{:name => "foo", :args => ["bar", {:name => "baz", :args => ["oof"]}]}]
      assert_parsed "[[foo]]", [{:name => {:name => "foo", :args => []}, :args => []}]
    end
  end
end
