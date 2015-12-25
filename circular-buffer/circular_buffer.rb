class CircularBuffer
  class BufferEmptyException < Exception
  end

  attr_accessor :buffer
  attr_reader :size

  def initialize(size)
    @size = size
    @buffer = []
  end

  def write(data)
    self.buffer << data if buffer.length < self.size
  end

  def read
    raise BufferEmptyException if buffer.empty?
    buffer.shift
  end

  def clear
    self.buffer.clear
  end

end