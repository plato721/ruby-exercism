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

  def exists(value)
    location = self.set.index(value)
    return false if !location
    self.set[location].class == value.class
  end

  def delete(value)
    return CustomSet.new(self.set) if !exists(value)
    self.set.delete(value)
    CustomSet.new(self.set)
  end

  def difference(other)
    items = self.set.each_with_object([]) do |element, differences|
      differences << element if !other.exists(element)
    end
    CustomSet.new(items)
  end

  def disjoint?(other)
    difference(other) == self
  end

  def empty
    CustomSet.new(self.set.clear)
  end
end
