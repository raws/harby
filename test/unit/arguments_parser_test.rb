require "test_helper"

module Harby
  class ArgumentsParserTest < TestCase
    def setup
      @parser = Grammar::ArgumentsParser.new
    end
    
    test "an empty string should not parse" do
      assert_not_parsed ""
      assert_not_parsed " "
    end
    
    test "whitespace before or after arguments should not parse" do
      assert_not_parsed " foo"
      assert_not_parsed "foo "
      assert_not_parsed " foo "
    end
    
    test "mixed string identifiers should not parse" do
      assert_not_parsed "'foo'bar"
    end
    
    test "a naked string argument" do
      assert_parsed "foo", ["foo"]
      assert_parsed "foo\\ ", ["foo "]
      assert_parsed "\\ foo", [" foo"]
      assert_parsed "foo\\ \\ ", ["foo  "]
      assert_parsed "foo\\ bar", ["foo bar"]
      assert_parsed 'foo"bar"', ['foo"bar"']
      assert_parsed "foo'bar'", ["foo'bar'"]
      assert_parsed "'foo\"bar", ["'foo\"bar"]
    end
    
    test "multiple naked string arguments" do
      assert_parsed "foo bar", ["foo", "bar"]
      assert_parsed "foo  bar", ["foo", "bar"]
      assert_parsed "foo\\ bar baz", ["foo bar", "baz"]
      assert_parsed "foo bar  baz", ["foo", "bar", "baz"]
      assert_parsed "foo bar \\ baz", ["foo", "bar", " baz"]
    end
    
    test "a single-quoted string argument" do
      assert_parsed "'foo'", ["foo"]
      assert_parsed "'foo '", ["foo "]
      assert_parsed "' foo'", [" foo"]
      assert_parsed "'foo bar'", ["foo bar"]
      assert_parsed "'foo\\'bar'", ["foo'bar"]
    end
    
    test "multiple single-quoted string arguments" do
      assert_parsed "'foo' 'bar'", ["foo", "bar"]
      assert_parsed "'foo bar' 'baz'", ["foo bar", "baz"]
    end
    
    test "a single double-quoted string" do
      skip "Not yet implemented"
      assert_parsed '"foo"', ["foo"]
      assert_parsed '"foo bar"', ["foo bar"]
      assert_parsed '" foo"', [" foo"]
      assert_parsed '"foo "', ["foo "]
    end
    
    test "mixed string arguments" do
      assert_parsed "foo 'bar baz'", ["foo", "bar baz"]
      assert_parsed "foo\\ bar 'baz\\'oo'", ["foo bar", "baz'oo"]
      assert_parsed "foo ' bar ' baz\\ ", ["foo", " bar ", "baz "]
    end
    
    def assert_parsed(input, expected)
      result = @parser.parse(input)
      flunk "Failed to parse #{input.inspect}: #{@parser.failure_reason}" unless result
      assert_equal expected, result.parsed_args
    end
    
    def assert_not_parsed(input)
      assert_nil @parser.parse(input)
    end
  end
end
