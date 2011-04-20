module Treetop
  module Runtime
    class CompiledParser
      include Harby::Concerns::Delegation
      alias_method :parse_without_reference, :parse
      
      def parse(*args)
        result = parse_without_reference(*args)
        if delegate && result.respond_to?(:delegate=)
          result.delegate = delegate
        end
        result
      end
    end
  end
end
