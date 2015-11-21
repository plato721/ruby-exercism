class Roman
  def self.roman_map
    {1000 => 'M',
      900 => 'CM',
      500 => 'D',
      400 => 'CD',
      100 => 'C',
       90 => 'XC',
       50 => 'L',
       40 => 'XL',
       10 => 'X',
        9 => 'IX',
        5 => 'V',
        4 => 'IV',
        1 => 'I'}
  end

  def self.max_roman
    3999
  end

  def self.to_roman(num)
    raise ArgumentError, "Too Large" if num > max_roman
    roman_map.each_with_object("") do |(decimal, roman), converted|
      until num < decimal
        converted << roman
        num -= decimal
      end
    end
  end
end

class Fixnum
  def to_roman
    Roman.to_roman(self)
  end
end

if __FILE__ == $0
  (1..100).each { |n| puts n.to_roman }
end