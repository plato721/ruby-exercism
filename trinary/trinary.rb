class Trinary
  def initialize(number)
    @number = number
  end
  def to_decimal(base=3)
    converted = 0
    @number.reverse.chars.each_with_index do |digit, index|
      converted += digit.to_i * (base ** index)
    end
    converted
  end
end