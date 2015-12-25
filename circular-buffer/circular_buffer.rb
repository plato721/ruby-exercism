class CircularBuffer
  class BufferEmptyException < Exception
  end
  
  def initialize(arg)
  end
  def read
    raise BufferEmptyException
  end

end