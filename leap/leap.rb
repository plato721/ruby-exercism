module Year
  def self.leap?(year)
    is_leap = false

    if year % 4 == 0 # must be divisible by 4
      is_leap = leap_verify(year) # now check exceptions
    end

    print_leap(year, is_leap)
    is_leap
  end

  # function to check for exception leap years
  #   for years already known to be divisible by 4
  def self.leap_verify(year)
    raise ArgumentError if year % 4 != 0
    true unless (year % 100 == 0) && (year % 400 != 0)
  end

  def self.print_leap(year, is_leap)
    if is_leap
      "Yes, #{year} is a leap year."
    else
      "No, #{year} is not a leap year."
    end
  end
end