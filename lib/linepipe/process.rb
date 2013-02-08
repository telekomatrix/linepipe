require "linepipe/dsl"

module Linepipe
  class Process
    include DSL
    attr_reader :output, :steps

    def initialize(io=STDOUT)
      @data         = []
      @steps        = []
      @setup        = nil
      @output       = nil
      @expectations = []
      @io           = io
    end

    def [](name)
      steps.detect { |s| s.name == name }
    end

    def run
      run_setup
      @output = steps.reduce(@data.call) { |d, step| step.apply(d) }
    end

    def develop
      run_setup
      @output = steps.to_enum.with_index.reduce(@data.call) { |d, (step, idx)|
        io.puts "Stage #{idx} #{step.name}"
        io.puts "Input: #{d}"
        step.apply(d).tap do |r|
          io.puts "Output: #{r}"
        end
      }

      if expectations.all? { |exp| exp.successful?(output) }
        io.puts "SUCCESS!"
      end
    end

    def benchmark(iterations)
      require 'benchmark'
      require 'stringio'

      run_setup

      label_length = steps.map(&:name).map(&:length).max

      out = $stdout
      $stdout = stringio = StringIO.new

      Benchmark.bmbm(label_length) do |x|
        @output = steps.reduce(@data.call) { |d, step|
          result = step.apply(d)
          x.report(step.name) { iterations.times { step.apply(d) } }
          result
        }
      end

      io.puts stringio.string
    ensure
      $stdout = out
    end

    private
    attr_reader :expectations, :io

    def run_setup
      @setup.call if @setup
    end
  end
end

