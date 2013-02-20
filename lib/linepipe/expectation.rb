module Linepipe
  class Expectation
    def initialize(msg = "Assertion failed", log_method = nil, &block)
      @msg, @log_method, @block = msg, log_method, block
    end

    def successful?(data)
      if !block.call(data)
        log_method.call("Expectation", "Failed at #{block.source_location.join(':')} (#{msg})")
        return false
      end
      true
    end

    private
    attr_reader :block, :msg, :log_method
  end
end

