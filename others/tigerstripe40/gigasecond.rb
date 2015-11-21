require 'date'
require 'time'

class Gigasecond

  VERSION = 1
  
  def self.from(startDate)
      endDate = startDate + 1000000000
      return endDate
  end
end