class Deque
  attr_accessor :head

  def initialize
    @head = nil
  end

  def push(data)
    node = Node.new(data)
    attach_at_end(node)
  end

  def attach_at_end(start=head, node)
    if empty?
      self.head = node
    elsif start.next.nil?
      start.next = node
    else
      attach_at_end(start.next, node)
    end
  end

  def pop(prev=head, start=head)
    return nil if empty?
    if start.next.nil?
      prev.next = nil
      start.data
    else
      pop(start, start.next)
    end
  end

  def unshift(data)
    node = Node.new(data, self.head)
    self.head = node
  end

  def shift
    return nil if empty?
    data = head.data
    self.head = head.next
    data
  end

  def empty?
    self.head.nil?
  end
end

class Node
  attr_reader :data
  attr_accessor :next

  def initialize(data, arg=nil)
    @data = data
    @next = arg
  end
end