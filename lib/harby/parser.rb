module Harby
  class Parser
    attr_reader :parser

    def initialize(delegate = nil, &block)
      @parser = Grammar::ArgumentsParser.new
      @parser.delegate = delegate || block
    end

    def delegate=(delegate)
      @parser.delegate = delegate
    end

    def delegate
      @parser.delegate
    end

    def failure_reason
      @parser.failure_reason
    end

    def parse(input)
      result = @parser.parse(input)
      result ? result.parsed_args : nil
    end
  end
end
