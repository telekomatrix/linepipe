require "linepipe/expectation"
require "linepipe/step"

module Linepipe
  module DSL
    def setup(&block)
      @setup = block
    end

    def data(data=nil, &block)
      @data = data ? -> { data } : block
    end

    def step(name=nil, &block)
      @steps << Step.new(name, &block)
    end

    def expect(msg=nil, &block)
      @expectations << Expectation.new(msg, io, &block)
    end
  end
end
