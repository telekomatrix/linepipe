require 'rspec'
require 'linepipe'
require 'stringio'

module Linepipe
  describe Expectation, '#successful?' do
    let(:io) { StringIO.new }

    describe 'when it fails' do
      let(:expectation) do
        Expectation.new('Failure message', io) { false }
      end

      it 'prints the message to the output' do
        expectation.successful?(%w(some data))
        expect(io.string).to match(/expectation_spec/)
        expect(io.string).to match(/Failure message/)
      end

      it 'returns false' do
        expect(expectation.successful?(%w(some data))).to be_false
      end
    end

    describe 'when it passes' do
      let(:expectation) do
        Expectation.new('Failure message', io) { true }
      end

      it 'returns true' do
        expect(expectation.successful?(%w(some data))).to be_true
      end
    end
  end
end
