# frozen_string_literal: true

require_relative('../lib/two_fer')
RSpec.describe TwoFer do
  it 'Tests no name given' do
    expect(TwoFer.two_fer).to(eq('One for you, one for me.'))
  end
  it 'Tests a name given' do
    expect(TwoFer.two_fer('Alice')).to(eq('One for Alice, one for me.'))
  end
  it 'Tests another name given' do
    expect(TwoFer.two_fer('Bob')).to(eq('One for Bob, one for me.'))
  end
end
