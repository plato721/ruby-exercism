class SumOfMultiples

  @@factors = [3,5]

  def initialize(*factors)
    @factors = *factors
  end

  def self.to(max, factors=@@factors)
    (1...max).select {|x| (factors.any? {|y| x % y == 0})}.reduce(0,:+)
  end

  def to(max)
    self.class.to(max, @factors)
  end

end
