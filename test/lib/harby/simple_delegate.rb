module Harby
  class SimpleDelegate
    def handle(name, args)
      name.gsub!(/\s/, "_")
      "#{name}(#{args.join(", ")})"
    end
  end
end
