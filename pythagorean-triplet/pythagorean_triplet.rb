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
    triples = []
    [*1..max].each do |c|
      [*1..max].each do |b|
        [*1..max].each do |a|
          triple = new(a, b, c)
          triples << triple if triple.pythagorean?
        end
      end
    end
    triples.uniq
  end

  def self.remove_dups(triples)
    triples.each_with_object([]) do |triple, uniques|
      uniques << triple if !(uniques.map(&:product).include?(triple.product))
    end
  end

  def self.where(args)
    check_max_factor(args)
    triples = triples_for(args[:max_factor])
    triples = remove_dups(triples)
    triples = apply_min(triples, min) if args[:min_factor]
    triples = apply_sum(triples, sum) if args[:sum]
    triples
  end

  def self.check_max_factor(args)
    raise Argument Error, "Must supply max factor" if !args[:max_factor]
  end
end