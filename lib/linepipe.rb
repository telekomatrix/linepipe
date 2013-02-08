require "linepipe/version"
require "linepipe/process"

module Linepipe
  class << self
    def develop(&block)
      Process.new.tap do |process|
        process.instance_eval(&block)
        process.develop
      end
    end

    def run(&block)
      Process.new.tap do |process|
        process.instance_eval(&block)
        process.run
      end
    end

    def benchmark(iterations, &block)
      Process.new.tap do |process|
        process.instance_eval(&block)
        process.benchmark(iterations)
      end
    end
  end
end
