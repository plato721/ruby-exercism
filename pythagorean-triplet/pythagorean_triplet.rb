class Triplet
  attr_reader :a, :b, :c

  def initialize(*sides)
    @a = sides[0]
    @b = sides[1]
    @c = sides[2]
  end

  def sum
    self.a + self.b + self.c
  end

  def product
    self.a * self.b * self.c
  end

  def pythagorean?
    self.a**2 + self.b**2 == self.c**2
  end

  def self.triples_for(max)
    [*1..max].each_with_object([]) do |c, triples|
      [*1..max].each do |b|
        [*1..max].each do |a|
          triple = new(a, b, c)
          triples << triple if triple.pythagorean?
        end
      end
    end
  end

  def self.remove_dups(triples)
    triples.each_with_object([]) do |triple, uniques|
      uniques << triple if !(uniques.map(&:product).include?(triple.product))
    end
  end

  def self.above_min?(triple, min)
    triple.a > min && triple.b > min && triple.c > min
  end

  def self.apply_min(triples, min)
    triples.each_with_object([]) do |triple, min_checked|
      min_checked << triple if above_min?(triple, min)
    end
  end

  def self.apply_sum(triples, sum)
    triples.each_with_object([]) do |triple, sum_checked|
      sum_checked << triple if triple.sum == sum
    end
  end

  def self.where(args)
    check_max_factor(args)
    triples = triples_for(args[:max_factor])
    triples = remove_dups(triples)
    triples = apply_min(triples, args[:min_factor]) if args[:min_factor]
    triples = apply_sum(triples, args[:sum]) if args[:sum]
    triples
  end

  def self.check_max_factor(args)
    raise Argument Error, "Must supply max factor" if !args[:max_factor]
  end
end