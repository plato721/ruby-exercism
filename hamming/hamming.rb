module Hamming
  VERSION = 1
  
  def self.compute(a, b)
    if a.length != b.length
      raise ArgumentError, "Must provide equal length strings"
    end

    a.chars.zip(b.chars).count { |a, b| a != b }
  end
end
