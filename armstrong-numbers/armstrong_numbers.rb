class ArmstrongCalculator
  def self.singleton
    @@instance ||= new
  end

  def compute
    @armstrong_numbers ||= [*0..10_000_000].keep_if { |num| armstrong?(num) }
  end

  private

  def initialize; end

  def armstrong?(num)
    number_string = num.to_s
    power = number_string.length
    num == number_string.split('').inject(0) { |memo, num_char| memo + num_char.to_i**power }
  end
end

ArmstrongNumbers = ArmstrongCalculator.singleton.compute
