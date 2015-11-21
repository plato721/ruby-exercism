class SecretHandshake
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def commands
    return [] if !((0..31).include?(code))
    code < 16 ? shake : shake(code - 16).reverse
  end

  def shake(code = self.code)
    shake_mask(code).zip(shake_map).map do |mask, gesture|
      mask && gesture
    end.compact.reverse
  end

  def shake_mask(code)
    bin_mask = code.to_s(2).rjust(4, "0").chars.map(&:to_i)
    mask = bin_mask.map { |bit| bit == 1 ? true : nil }
  end
  
  def shake_map
    ["jump", "close your eyes", "double blink", "wink"]
  end
end