module Harby
  class ParserTestCase < TestCase
    def setup
      @parser = Parser.new(ReflectDelegate.new)
    end
    
    def assert_parsed(input, expected)
      result = @parser.parse(input)
      flunk "Failed to parse #{input.inspect}: #{@parser.failure_reason}" unless result
      assert_equal expected, result
    end
    
    def assert_not_parsed(input)
      assert_nil @parser.parse(input)
    end
  end
end
