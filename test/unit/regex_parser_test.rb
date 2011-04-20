require "test_helper"

module Harby
  class RegexParserTest < ParserTestCase
    test "a regex argument" do
      assert_parsed "/foo/", [/foo/]
      assert_parsed "/foo bar/", [/foo bar/]
      assert_parsed "/foo   bar/", [/foo   bar/]
      assert_parsed "/foo/i", [/foo/i]
      assert_parsed "/foo/ix", [/foo/ix]
      assert_parsed "/fo\\/o/", [/fo\/o/]
      assert_parsed "/f\\wo/", [/f\wo/]
      assert_parsed "/f[oO]+/", [/f[oO]+/]
      assert_parsed "/f[oO]{1,2}/", [/f[oO]{1,2}/]
    end
    
    test "an invalid regex argument" do
      assert_not_parsed "/foo/a"
    end
  end
end
