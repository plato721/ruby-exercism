class ArmstrongCalculator
  def initialize(max = 10_000_000)
    @max = max
  end

  def armstrong_numbers
    @armstrong_numbers ||= [*0..@max].keep_if { |num| armstrong_number?(num) }
  end

  def armstrong_number?(num)
    number_string = num.to_s
    power = number_string.length
    num == number_string.split('').inject(0) { |memo, num_char| memo + num_char.to_i**power }
  end
end

ArmstrongNumbers = ArmstrongCalculator.new.armstrong_numbers
