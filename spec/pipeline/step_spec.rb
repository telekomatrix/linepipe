require 'rspec'
require 'linepipe'

module Linepipe
  describe Step, '#apply' do
    let(:step) { Step.new('upcase', &:upcase) }

    it 'exposes a name' do
      expect(step.name).to eq('upcase')
    end

    describe '#apply' do
      it 'calls the block with the data' do
        expect(step.apply('data')).to eq('DATA')
      end
    end

    describe '#verify_expectations' do
      context 'when there are no expectations' do
        it 'returns an empty array' do
          expect(step.verify_expectations('DATA')).to eq([])
        end
      end

      it 'returns the expectations with their status' do
        step.expect('is upcased') { |data| data.upcase == data }
        step.expect('is downcased') { |data| data.downcase == data }
        expectations = step.verify_expectations('DATA')
        expect(expectations.first.status).to eq('pass')
        expect(expectations.last.status).to eq('fail')
      end
    end
  end
end

