# frozen_string_literal: true

require_relative('../lib/hello_world')

RSpec.describe HelloWorld do
  describe '#hello' do
    it 'Says hi' do
      expect(HelloWorld.hello).to(eq('Hello, World!'))
    end
  end
end
