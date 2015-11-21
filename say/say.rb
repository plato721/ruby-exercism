class Say
  attr_reader :number

  LOWS = {
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  TENS = {
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  PLACE_MAP = {
    :hundred => 100,
    :thousand => 1_000,
    :million => 1_000_000,
    :billion => 1_000_000_000
  }

  LOWER = 0
  UPPER = 999_999_999_999

  def initialize(number)
    @number = number
  end

  def in_english(num = self.number)
    raise ArgumentError if !(LOWER..UPPER).include?(num)
    if num < 20
      low(num)
    elsif num < 100
      ten(num)
    elsif num < 1000
      high(:hundred, num)
    elsif num < 1_000_000
      high(:thousand, num)
    elsif num < 1_000_000_000
      high(:million, num)
    else
      high(:billion, num)
    end
  end

  private
  def low(num)
    LOWS[num]
  end

  def ten(num)
    if number % 10 == 0
      TENS[num / 10]
    else
      TENS[num / 10] + "-" + LOWS[num % 10]
    end
  end

  def high(place, num)
    current = num / PLACE_MAP[place]
    lesser = num % PLACE_MAP[place]

    if lesser.zero?
      in_english(current) + " #{place.to_s}"
    else
      in_english(current) + " #{place.to_s} " + in_english(lesser)
    end 
  end

end