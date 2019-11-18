# frozen_string_literal: true

require_relative('../lib/resistor_color_duo')
RSpec.describe ResistorColorDuo do
  describe '#value' do
    it 'Tests brown and black' do
      expect(ResistorColorDuo.value(%w[brown black])).to(eq(10))
    end
    it 'Tests blue and grey' do
      expect(ResistorColorDuo.value(%w[blue grey])).to(eq(68))
    end
    it 'Tests yellow and violet' do
      expect(ResistorColorDuo.value(%w[yellow violet])).to(eq(47))
    end
    it 'Tests orange and orange' do
      expect(ResistorColorDuo.value(%w[orange orange])).to(eq(33))
    end
    it 'Test that it ignores additional colors' do
      expect(ResistorColorDuo.value(%w[green brown orange])).to(eq(51))
    end
  end
end
