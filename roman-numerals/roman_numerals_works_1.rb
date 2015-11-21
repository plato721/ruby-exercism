class Fixnum
  def to_roman
    if self > 4000
      "ain't happenin"
    else
      num = self
      converted = String.new
      until num < 1000
        converted << "M"
        num -= 1000        
      end
      if num >= 900
        converted << "CM"
        num -= 900
      elsif num >= 500
        converted << "D"
        num -= 500
      end
      if num >= 400
        converted << "CD"
        num -= 400
      end
      until num < 100
        converted << "C"
        num -= 100
      end
      if num >= 90
        converted << "XC"
        num -= 90
      end
      if num >= 50
        converted << "L"
        num -= 50
      end
      if num >= 40
        converted << "XL"
        num -= 40
      end
      until num < 10
        converted << "X"
        num -= 10
      end
      if num == 9
        converted << "IX"
        num -= 9
      end
      if num >= 5
        converted << "V"
        num -= 5
      end
      if num == 4
        converted << "IV"
        num -= 4
      end
      until num == 0
        converted << "I"
        num -= 1
      end
    end
    converted
  end
end

if __FILE__ == $0
  (1..100).each { |n| puts n.to_roman }
end