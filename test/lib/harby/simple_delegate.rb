module Harby
  class SimpleDelegate
    def on_command(name, args)
      name.gsub!(/\s/, "_")
      "#{name}(#{args.join(", ")})"
    end
  end
end
