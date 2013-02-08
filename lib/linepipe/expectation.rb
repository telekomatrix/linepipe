module Linepipe
  class Expectation
    def initialize(msg="Assertion failed", io=STDOUT, &block)
      @msg   = msg
      @io    = io
      @block = block
    end

    def successful?(data)
      if !block.call(data)
        io.puts "Expectation failed at #{block.source_location.join(':')} (#{msg})"
        return false
      end
      true
    end

    private
    attr_reader :block, :msg, :io
  end
end

