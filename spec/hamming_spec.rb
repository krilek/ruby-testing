# frozen_string_literal: true

require_relative('../lib/hamming')
RSpec.describe Hamming do
  describe '#compute' do

    it 'Tests empty strands' do
      expect(Hamming.compute('', '')).to(eq(0))
    end
  
    it 'Tests single letter identical strands' do
      expect(Hamming.compute('A', 'A')).to(eq(0))
    end
    it 'Tests single letter different strands' do
      expect(Hamming.compute('G', 'T')).to(eq(1))
    end
    it 'Tests long identical strands' do
      expect(Hamming.compute('GGACTGAAATCTG', 'GGACTGAAATCTG')).to(eq(0))
    end
    it 'Tests long different strands' do
      expect(Hamming.compute('GGACGGATTCTG', 'AGGACGGATTCT')).to(eq(9))
    end
    context 'when wrong strand' do
      it 'Tests disallow first strand longer' do
        expect { Hamming.compute('AATG', 'AAA') }.to(raise_error(ArgumentError))
      end
      it 'Tests disallow second strand longer' do
        expect { Hamming.compute('ATA', 'AGTG') }.to(raise_error(ArgumentError))
      end
    end
  end
end
