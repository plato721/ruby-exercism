class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(value)
    @data = value
  end

  def insert(value)
    if value <= data
      left.nil? ? self.left = Bst.new(value) : left.insert(value)
    else
      right.nil? ? self.right = Bst.new(value) : right.insert(value)
    end
  end

  def traverse
    [].concat(traverse_left).push(data).concat(traverse_right)
  end

  def traverse_left
    left.nil? ? [] : left.traverse
  end

  def traverse_right
    right.nil? ? [] : right.traverse
  end

  def each
    traverse.each { |data| yield data }
  end
end