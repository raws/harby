require "test_helper"

module Harby
  class StringParserTest < ParserTestCase
    test "an empty string should not parse" do
      assert_not_parsed ""
      assert_not_parsed " "
    end
    
    test "whitespace before or after arguments should not parse" do
      assert_not_parsed " foo"
      assert_not_parsed "foo "
      assert_not_parsed " foo "
    end
    
    test "mismatched identifiers should not parse" do
      assert_not_parsed "'foo'bar"
      assert_not_parsed '"foo"bar'
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
      assert_parsed '"foo"', ["foo"]
      assert_parsed '"foo bar"', ["foo bar"]
      assert_parsed '" foo"', [" foo"]
      assert_parsed '"foo "', ["foo "]
      assert_parsed '"foo \"bar\""', ['foo "bar"']
      assert_parsed '"foo \'bar\'"', ["foo 'bar'"]
    end
    
    test "mixed string arguments" do
      assert_parsed "foo 'bar baz'", ["foo", "bar baz"]
      assert_parsed "foo\\ bar 'baz\\'oo'", ["foo bar", "baz'oo"]
      assert_parsed "foo ' bar ' baz\\ ", ["foo", " bar ", "baz "]
      assert_parsed %{"foo 'bar'" baz 'oo'}, ["foo 'bar'", "baz", "oo"]
    end
  end
end
