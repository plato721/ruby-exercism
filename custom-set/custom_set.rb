class CustomSet
  include Enumerable
  attr_accessor :set

  def initialize(collection = [])
    @set = create_set(collection)
  end

  def create_set(arg)
    arg = *arg if arg.is_a?(Range)
    arg.uniq.sort
  end

  def ==(other)
    self.set == other.set
  end

  def member?(value)
    location = self.set.index(value)
    return false if !location
    self.set[location].class == value.class
  end

  def delete(value)
    return CustomSet.new(self.set) if !member?(value)
    self.set.delete(value)
    CustomSet.new(self.set)
  end

  def difference(other)
    CustomSet.new(self.select { |e| !other.member?(e) })
  end

  def disjoint?(other)
    difference(other) == self
  end

  def intersection(other)
    CustomSet.new( self.select { |e| other.member?(e) })
  end

  def empty
    self.set.clear
    self
  end

  def put(value)
    self.set << value if !member?(value)
    self.set.sort!
    self
  end

  def size
    self.set.length
  end

  def subset?(other)
    other.intersection(self) == other
  end

  def union(other)
    other.each { |element| self.put(element) }
    self
  end

  def each
    self.set.each { |element| yield element }
  end
end
