module Harby
  class ReflectDelegate
    def on_command(name, args)
      { :name => name, :args => args }
    end
  end
end
