module Harby
  class ReflectDelegate
    def handle(name, args)
      { :name => name, :args => args }
    end
  end
end
