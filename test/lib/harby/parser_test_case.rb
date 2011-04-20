module Harby
  class ParserTestCase < TestCase
    def setup
      @parser = Parser.new(ReflectDelegate.new)
    end
    
    def assert_parsed(input, expected)
      result = @parser.parse(input)
      flunk "Failed to parse #{input.inspect}: #{@parser.failure_reason}" unless result
      expected.zip(result) do |expected, parsed|
        if expected.is_a?(Hash)
          expected.each do |method, value|
            assert_equal value, parsed[method]
          end
        else
          assert_equal expected, parsed
        end
      end
    end
    
    def assert_not_parsed(input)
      assert_nil @parser.parse(input)
    end
  end
end
