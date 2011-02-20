module Harby
  class TestCase < MiniTest::Unit::TestCase
    def self.test(name, &block)
      define_method "test #{name.inspect}", &block
    end
  end
end
