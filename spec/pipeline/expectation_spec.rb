require 'rspec'
require 'linepipe'
require 'stringio'

module Linepipe
  describe Expectation, '#successful?' do
    let(:io) { StringIO.new }
    let(:log) { double('Log') }

    before do
      log.stub(:call)
    end

    describe 'when it fails' do
      let(:expectation) do
        Expectation.new('Failure message', log) { false }
      end

      it 'prints the message to the output' do
        log.should_receive(:call) do |topic, msg|
          expect(topic).to match(/expectation/i)
          expect(msg).to match(/Failure message/)
        end
        expectation.successful?(%w(some data))
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
