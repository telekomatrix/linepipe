module Linepipe
  class Step
    attr_reader :name

    def initialize(name=nil, &block)
      @name  = name
      @block = block
    end

    def apply(data)
      block.call(data)
    end

    private
    attr_reader :block
  end
end

