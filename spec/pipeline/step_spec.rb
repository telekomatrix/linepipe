require 'rspec'
require 'linepipe'

module Linepipe
  describe Step, '#apply' do
    let(:step) { Step.new('upcase', &:upcase) }

    it 'exposes a name' do
      expect(step.name).to eq('upcase')
    end

    it 'calls the block with the data' do
      expect(step.apply('data')).to eq('DATA')
    end
  end
end

