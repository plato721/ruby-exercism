class Palindromes
  attr_reader :max_factor, :min_factor
  attr_accessor :pal_pairs

  def initialize(args)
    @max_factor = args[:max_factor]
    @min_factor = args.fetch(:min_factor, 1)
  end

  def generate
    self.pal_pairs = all_pairs.select { |pair| palindrome?(pair.to_a) }
  end

  def smallest
    min = self.pal_pairs.min
    all_min = self.pal_pairs.select { |pair| pair == min }
    PairGroup.new(all_min)
  end

  def largest
    max = self.pal_pairs.max
    all_max = self.pal_pairs.select { |pair| pair == max }
    PairGroup.new(all_max)
  end

  private
  def all_pairs
    pool = [*min_factor..max_factor].concat([*min_factor..max_factor])
    pairs = pool.combination(2).to_a.map { |pair| Pair.new(pair) }
    pairs.uniq
  end

  def palindrome?(pair)
    product = pair.first * pair.last
    product.to_s == product.to_s.reverse
  end
end

class PairGroup
  attr_reader :pairs

  def initialize(pairs)
    @pairs = pairs
  end

  def value
    self.factors.first.reduce(:*)
  end

  def factors
    @pairs.map { |pair| pair.to_a }
  end
end

class Pair
  include Comparable
  include Enumerable

  attr_reader :a, :b

  def initialize(pair)
    @a = pair.min
    @b = pair.max
  end

  def <=>(other)
    (self.a * self.b) <=> (other.a * other.b)
  end

  def hash #needed for uniq
    [self.a, self.b].hash
  end

  def eql?(other) #needed for uniq
    (self.a * self.b) == (other.a * other.b)
  end

  def each
    self.to_a.each
  end

  def to_a
    [@a, @b]
  end
end