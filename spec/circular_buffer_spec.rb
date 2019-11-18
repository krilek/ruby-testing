# frozen_string_literal: true

require_relative('../lib/circular_buffer')
RSpec.describe CircularBuffer do
  describe '.read' do
    it 'reads empty buffer and throws buffer empty exception' do
      buffer = CircularBuffer.new(1)
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
    it 'reads back oldest item' do
      buffer = CircularBuffer.new(3)
      buffer.write('1')
      buffer.write('2')
      buffer.read
      buffer.write('3')
      expect(buffer.read).to(eq('2'))
      expect(buffer.read).to(eq('3'))
    end
  end
  describe '.write' do
    it 'writes and reads back one item' do
      buffer = CircularBuffer.new(1)
      buffer.write('1')
      expect(buffer.read).to(eq('1'))
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
    
    it 'writes and reads back multiple items' do
      buffer = CircularBuffer.new(2)
      buffer.write('1')
      buffer.write('2')
      expect(buffer.read).to(eq('1'))
      expect(buffer.read).to(eq('2'))
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
    
    it 'alternatively write and read' do
      buffer = CircularBuffer.new(2)
      buffer.write('1')
      expect(buffer.read).to(eq('1'))
      buffer.write('2')
      expect(buffer.read).to(eq('2'))
    end
    it 'writes to a full buffer throws an exception' do
      buffer = CircularBuffer.new(2)
      buffer.write('1')
      buffer.write('2')
      expect { buffer.write('A') }.to(raise_error(CircularBuffer::BufferFullException))
    end
    it 'overwrites oldest item in a full buffer' do
      buffer = CircularBuffer.new(2)
      buffer.write('1')
      buffer.write('2')
      buffer.write!('A')
      expect(buffer.read).to(eq('2'))
      expect(buffer.read).to(eq('A'))
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
    it 'forced writes to non full buffer should behave like writes' do
      buffer = CircularBuffer.new(2)
      buffer.write('1')
      buffer.write!('2')
      expect(buffer.read).to(eq('1'))
      expect(buffer.read).to(eq('2'))
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
    it 'alternatively read and write into buffer to cause overflow' do
      buffer = CircularBuffer.new(5)
      ('1'..'3').each { |i| buffer.write(i) }
      buffer.read
      buffer.read
      buffer.write('4')
      buffer.read
      ('5'..'8').each { |i| buffer.write(i) }
      buffer.write!('A')
      buffer.write!('B')
      ('6'..'8').each { |i| expect(buffer.read).to(eq(i)) }
      expect(buffer.read).to(eq('A'))
      expect(buffer.read).to(eq('B'))
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
    end
  end
  describe '.clear' do
    it 'clear buffer' do
      buffer = CircularBuffer.new(3)
      ('1'..'3').each { |i| buffer.write(i) }
      buffer.clear
      expect { buffer.read }.to(raise_error(CircularBuffer::BufferEmptyException))
      buffer.write('1')
      buffer.write('2')
      expect(buffer.read).to(eq('1'))
      buffer.write('3')
      expect(buffer.read).to(eq('2'))
    end
  end
  
  

end
