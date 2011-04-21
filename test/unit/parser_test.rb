require "test_helper"

module Harby
  class ParserTest < TestCase
    test "parsing arguments with a parser instance" do
      parser = Parser.new
      assert_equal ["foo", 123, "bar"], parser.parse("foo 123 bar")
    end
    
    test "parsing invalid arguments with a parser instance" do
      parser = Parser.new
      assert_equal nil, parser.parse("'foo'bar")
    end
    
    test "parsing arguments using Parser.parse" do
      assert_equal ["foo", 123, "bar"], Parser.parse("foo 123 bar")
    end
    
    test "parsing arguments using Harby.parse" do
      assert_equal ["foo", 123, "bar"], Harby.parse("foo 123 bar")
    end
    
    test "passing a delegate to Parser.parse" do
      refute_equal Parser.parse("[foo bar]"), Parser.parse("[foo bar]", SimpleDelegate.new)
      assert_equal ["foo(bar)"], Parser.parse("[foo bar]", SimpleDelegate.new)
    end
    
    test "passing a delegate to Harby.parse" do
      refute_equal Harby.parse("[foo bar]"), Harby.parse("[foo bar]", SimpleDelegate.new)
      assert_equal ["foo(bar)"], Harby.parse("[foo bar]", SimpleDelegate.new)
    end
  end
end
