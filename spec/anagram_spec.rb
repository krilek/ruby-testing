# frozen_string_literal: true

require_relative('../lib/anagram')
RSpec.describe Anagram do
  describe '.match' do
    it 'Tests no matches' do
      detector = Anagram.new('diaper')
      anagrams = detector.match(%w[hello world zombies pants])
      expected = []
      expect(anagrams).to(eq(expected))
    end
    it 'Detects two anagrams' do
      detector = Anagram.new('master')
      anagrams = detector.match(%w[stream pigeon maters])
      expected = %w[maters stream]
      expect(anagrams.sort).to(eq(expected))
    end
    it 'Does not detect anagram subsets' do
      detector = Anagram.new('good')
      anagrams = detector.match(%w[dog goody])
      expected = []
      expect(anagrams).to(eq(expected))
    end
    it 'Detects anagram' do
      detector = Anagram.new('listen')
      anagrams = detector.match(%w[enlists google inlets banana])
      expected = ['inlets']
      expect(anagrams).to(eq(expected))
    end
    it 'Detects three anagrams' do
      detector = Anagram.new('allergy')
      anagrams = detector.match(%w[gallery ballerina regally clergy largely leading])
      expected = %w[gallery largely regally]
      expect(anagrams.sort).to(eq(expected))
    end
    it 'Does not detect non anagrams with identical checksum' do
      detector = Anagram.new('mass')
      anagrams = detector.match(['last'])
      expected = []
      expect(anagrams).to(eq(expected))
    end
    context 'when insensitive' do
      it 'detects anagrams' do
        detector = Anagram.new('Orchestra')
        anagrams = detector.match(%w[cashregister Carthorse radishes])
        expected = ['Carthorse']
        expect(anagrams).to(eq(expected))
      end
      it 'detects anagrams using case insensitive subject' do
        detector = Anagram.new('Orchestra')
        anagrams = detector.match(%w[cashregister carthorse radishes])
        expected = ['carthorse']
        expect(anagrams).to(eq(expected))
      end
      it 'detects anagrams using case insensitive possible matches' do
        detector = Anagram.new('orchestra')
        anagrams = detector.match(%w[cashregister Carthorse radishes])
        expected = ['Carthorse']
        expect(anagrams).to(eq(expected))
      end
      it 'tests words that are not anagrams of themselves' do
        detector = Anagram.new('BANANA')
        anagrams = detector.match(%w[BANANA Banana banana])
        expected = []
        expect(anagrams).to(eq(expected))
      end
    end
    
    it 'Does not detect a anagram if the original word is repeated' do
      detector = Anagram.new('go')
      anagrams = detector.match(['go Go GO'])
      expected = []
      expect(anagrams).to(eq(expected))
    end
    it 'Tests that anagrams must use all letters exactly once' do
      detector = Anagram.new('tapper')
      anagrams = detector.match(['patter'])
      expected = []
      expect(anagrams).to(eq(expected))
    end
    
  end
end
