module Harby
  class Parser
    attr_reader :parser
    
    def initialize(delegate = nil)
      @parser = Grammar::ArgumentsParser.new
      @parser.delegate = delegate || NullDelegate.new
    end
    
    def parse(input)
      result = @parser.parse(input)
      result ? result.parsed_args : nil
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
    
    def self.parse(input)
      new.parse(input)
    end
  end
  
  def self.parse(input)
    Parser.parse(input)
  end
end
