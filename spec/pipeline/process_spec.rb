require 'rspec'
require 'linepipe'
require 'stringio'

module Linepipe
  describe Process do
    let(:io) { StringIO.new }

    let(:process) do
      Process.new(io).tap do |process|
        process.setup { process.taint }
        process.data { %w(foo bar baz) }
        process.step('Upcasing') { |data| data.map(&:upcase) }
        process.step('Reversing', &:reverse)
        process.expect { |data| data.first == 'BAZ' }
      end
    end

    describe '#[]' do
      it 'gets a step' do
        step = process['Upcasing']
        expect(step.apply(['blah'])).to eq(['BLAH'])
      end
    end

    describe '#run' do
      before do
        process.run
      end

      it 'runs the setup' do
        expect(process).to be_tainted
      end

      it 'assigns the output' do
        expect(process.output).to eq(%w(BAZ BAR FOO))
      end
    end

    describe '#develop' do
      it 'runs the setup' do
        process.develop
        expect(process).to be_tainted
      end

      it 'assigns the output' do
        process.develop
        expect(process.output).to eq(%w(BAZ BAR FOO))
      end

      it 'outputs information to the io stream' do
        process.develop
        expect(io.string).to match(/Stage 0 Upcasing/)
        expect(io.string).to match(/Stage 1 Reversing/)
      end

      describe 'when the expectations pass' do
        it 'outputs SUCCESS' do
          process.develop
          expect(io.string).to match(/SUCCESS/)
        end
      end

      describe 'when the expectations fail' do
        before do
          process.expect('is not a number!') { |data| data.kind_of?(Numeric) }
          process.develop
        end

        it 'does not output SUCCESS' do
          expect(io.string).to_not match(/SUCCESS/)
        end

        it 'outputs errors' do
          expect(io.string).to match(/is not a number!/)
        end
      end
    end

    describe '#benchmark' do
      before do
        process.benchmark(2)
      end

      it 'runs the setup' do
        expect(process).to be_tainted
      end

      it 'assigns the output' do
        expect(process.output).to eq(%w(BAZ BAR FOO))
      end

      it 'outputs the benchmark results' do
        expect(io.string).to match(/real/)
      end
    end
  end
end

