require "test_helper"

module Harby
  class SymbolParserTest < ParserTestCase
    test "a symbol argument" do
      assert_parsed ":foo", [:foo]
      assert_parsed ":foo_bar", [:foo_bar]
      assert_parsed ":Foo", [:Foo]
      assert_parsed ":FooBar", [:FooBar]
    end
    
    test "an invalid symbol argument" do
      assert_parsed "::foo", ["::foo"]
      assert_not_parsed ":foo.bar"
      assert_not_parsed ":foo\\ bar"
    end
    
    test "multiple symbol arguments" do
      assert_parsed ":foo :bar", [:foo, :bar]
      assert_parsed ":foo_bar :baz", [:foo_bar, :baz]
    end
  end
end
