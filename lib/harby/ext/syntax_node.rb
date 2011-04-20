module Treetop
  module Runtime
    class SyntaxNode
      include Harby::Concerns::Delegation
      alias_method :elements_without_reference, :elements
      
      def elements(*args)
        elements = elements_without_reference(*args) || []
        @comprehensive_elements = elements.map do |element|
          element.delegate = delegate
          element
        end
      end
    end
  end
end
