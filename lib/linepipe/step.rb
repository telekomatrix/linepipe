module Linepipe
  class Step
    attr_reader :name

    def initialize(name=nil, &block)
      @name  = name
      @block = block
      @expectations = []
    end

    def apply(data)
      block.call(data)
    end

    def verify_expectations(result)
      @expectations.each { |exp| exp.verify(result) }
    end

    def expect(name=nil, &block)
      @expectations << StepExpectation.new(name, &block)
    end

    private
    attr_reader :block

    class StepExpectation
      attr_reader :name, :status

      def initialize(name=nil, &test)
        @name   = name
        @test   = test
        @status = 'not run'
      end

      def verify(data)
        @status = @test.call(data) ? 'pass' : 'fail'
      end
    end
  end
end

