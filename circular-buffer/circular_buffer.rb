class CircularBuffer
  class BufferEmptyException < Exception
  end

  class BufferFullException < Exception
  end

  attr_accessor :buffer
  attr_reader :size

  def initialize(size)
    @size = size
    @buffer = []
  end

  def full?
    buffer.length == size
  end

  def empty?
    buffer.empty?
  end

  def read
    raise BufferEmptyException if empty?
    buffer.shift
  end

  def write(data)
    raise BufferFullException if full?
    self.buffer << data if !data.nil?
  end

  def write!(data)
    return if data.nil?
    buffer.shift if full?
    write(data)
  end

  def clear
    self.buffer.clear
  end
end
