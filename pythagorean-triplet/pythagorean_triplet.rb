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

  def self.triples_for(args)
    max = args[:max_factor]
    min = args[:min_factor] || 1

    [*min..max].each_with_object([]) do |c, triples|
      [*min..max - 1].each do |b|
        [*min..max - 2].each do |a|
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

  def self.apply_sum(triples, sum)
    triples.each_with_object([]) do |triple, sum_checked|
      sum_checked << triple if triple.sum == sum
    end
  end

  def self.where(args)
    check_max_factor(args)
    triples = triples_for(args)
    triples = remove_dups(triples)
    triples = apply_sum(triples, args[:sum]) if args[:sum]
    triples
  end

  def self.check_max_factor(args)
    raise Argument Error, "Must supply max factor" if !args[:max_factor]
  end
end