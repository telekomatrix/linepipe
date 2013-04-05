require_relative "expectation"
require_relative "step"

module Linepipe
  module DSL
    def setup(&block)
      @setup = block
    end

    def data(data=nil, &block)
      @data = data ? -> { data } : block
    end

    def step(name=nil, &block)
      @steps << step = Step.new(name, &block)
      step
    end

    def expect(msg=nil, &block)
      @expectations << Expectation.new(msg, method(:log), &block)
    end
  end
end
