class Luhn
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def addends
    raw_addends.map do |digit|
      digit < 10 ? digit : digit - 9
    end
  end

  def checksum
    addends.inject(:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(num)
    [*0..9].each do |digit|
      possible = Luhn.new("#{num}#{digit}".to_i)
      return possible.num if possible.valid?
    end
  end

  private
  def raw_addends
    num.to_s.reverse.chars.map.with_index do |digit, index|
      index.odd? ? digit.to_i * 2 : digit.to_i
    end.reverse
  end
end