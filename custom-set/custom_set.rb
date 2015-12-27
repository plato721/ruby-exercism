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
    tap { self.set.delete(value) if member?(value) }
  end

  def difference(other)
    CustomSet.new(self.select { |element| !other.member?(element) })
  end

  def disjoint?(other)
    difference(other) == self
  end

  def intersection(other)
    CustomSet.new(self.select { |element| other.member?(element) })
  end

  def empty
    tap { self.set.clear }
  end

  def put(value)
    self.set << value if !member?(value)
    tap { self.set.sort! }
  end

  def size
    self.set.length
  end

  def subset?(other)
    other.intersection(self) == other
  end

  def union(other)
    tap { other.each { |element| self.put(element) } }
  end

  def each
    self.set.each { |element| yield element }
  end
end
