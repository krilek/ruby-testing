class CircularBuffer
    class BufferEmptyException < StandardError; end
    class BufferFullException < StandardError; end
  
  
    def initialize(size)
      @buffer = []
      @size = size
    end
  
    def read
      raise BufferEmptyException if empty?
      @buffer.shift
    end
  
    def write(data)
      raise BufferFullException if full?
      @buffer.append(data)
    end
  
    def write!(data)
      @buffer.shift if full?
      write(data)
    end
  
    def clear
      @buffer.clear
    end
  
    private
      attr_reader :size
      attr_accessor :buffer
  
      def full?
        buffer.size == size
      end
  
      def empty?
        buffer.empty?
      end
  end