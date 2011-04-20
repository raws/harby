module Treetop
  module Runtime
    class SyntaxNode
      include Harby::Concerns::Delegation
      alias_method :elements_without_reference, :elements
      
      def elements(*args)
        @comprehensive_elements = elements_without_reference(*args).map do |element|
          element.delegate = delegate
          element
        end
      end
    end
  end
end
