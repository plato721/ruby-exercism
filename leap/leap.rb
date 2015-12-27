module Year
  def self.leap?(year)
    return false if year % 4 != 0
    true unless (year % 100 == 0) && (year % 400 != 0)
  end
end