module Raindrops
  MESSAGES = {
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  def self.convert(num)
    msg(num).empty? ? "#{num}" : "#{msg(num)}"
  end
 
  def self.msg(num)
    MESSAGES.each_with_object("") do |(factor, msg), output|
      output << msg if num % factor == 0
    end
  end

  private_class_method :msg
end