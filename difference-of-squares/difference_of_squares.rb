class Squares
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def difference
    square_of_sums - sum_of_squares
  end

  def sum_of_squares
    [*1..self.num].map{ |x| x ** 2 }.reduce(:+)
  end

  def square_of_sums
    [*1..self.num].reduce(:+) ** 2
  end
end