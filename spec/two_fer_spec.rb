# frozen_string_literal: true

require_relative('../lib/two_fer')
RSpec.describe TwoFer do
  describe '#two_fer' do
    it 'no name given' do
      expect(TwoFer.two_fer).to(eq('One for you, one for me.'))
    end
    it 'a name given' do
      expect(TwoFer.two_fer('Alice')).to(eq('One for Alice, one for me.'))
    end
    it 'another name given' do
      expect(TwoFer.two_fer('Bob')).to(eq('One for Bob, one for me.'))
    end  
  end
end
