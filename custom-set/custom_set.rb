class CustomSet
  attr_accessor :set

  def initialize(collection = [])
    @set = create_set(collection)
  end

  def create_set(arg)
    arg.uniq.sort
  end

  def ==(other)
    self.set == other.set
  end

  def contains(value)
    location = self.set.index(value)
    return false if !location
    self.set[location].class == value.class
  end

  def delete(value)
    return CustomSet.new(self.set) if !contains(value)
    self.set.delete(value)
    CustomSet.new(self.set)
  end

  def difference(other)
    items = self.set.each_with_object([]) do |element, differences|
      differences << element if !other.contains(element)
    end
    CustomSet.new(items)
  end

  def disjoint?(other)
    difference(other) == self
  end

  def intersection(other)
    elements = self.set.each_with_object([]) do |element, commons|
      commons << element if other.contains(element)
    end
    CustomSet.new(elements)
  end

  def empty
    CustomSet.new(self.set.clear)
  end
end
