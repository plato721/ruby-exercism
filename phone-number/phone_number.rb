class PhoneNumber
  attr_reader :number

  def initialize(number)
    @number_original = number
    @number = clean(@number_original)
  end

  def bad_number
    "0000000000"
  end

  def area_code
    @number[0..2]
  end

  def prefix
    @number[3..5]
  end

  def suffix
    @number[6..10]
  end

  def to_s
    "(#{area_code}) #{prefix}-#{suffix}"
  end

  private
  def clean(num)  
    num = bad_number if contains_alpha?(num)
    num = remove_non_digits(num)
    num = handle_lead_one(num)
    num = bad_number if num.length != 10
    num
  end

  def handle_lead_one(num)
    #remove leading 1 but only for 11-digit numbers
    num.slice!(0) if num[0] == "1" && num.length == 11
    num
  end

  def contains_alpha?(num)
    #must test for this first so remove_non_digs doesn't clean it
    num =~ /[a-zA-Z]/
  end

  def remove_non_digits(num)
    num.chars.keep_if{|n| n =~ /[\d]{1}/}.join
  end

end
