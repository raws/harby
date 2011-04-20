module Harby
  class TestDelegate
    def handle(name, args)
      { :name => name, :args => args }
    end
  end
end
