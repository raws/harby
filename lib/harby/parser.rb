module Harby
  class Parser
    def initialize
      @parser = Grammar::ArgumentsParser.new
    end
    
    def parse(input)
      result = @parser.parse(input)
      result ? result.parsed_args : nil
    end
    
    def self.parse(input)
      new.parse(input)
    end
  end
  
  def self.parse(input)
    Parser.parse(input)
  end
end
