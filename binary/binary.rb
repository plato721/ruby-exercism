class Binary
  VERSION = 1
  def initialize(num)
    raise ArgumentError if num.to_s.match(/[^10]+/) || num.class != String
    @num = num
  end
  def to_decimal
    bits = @num.reverse.chars
    bits.map.with_index {|bit, idx| bit.to_i * 2 ** idx }.reduce(:+)
  end
end