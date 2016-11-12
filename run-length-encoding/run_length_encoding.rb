class RunLengthEncoding
  require 'pry'

  def self.encode(word)
    result = ""
    word = word.split("")
    until word.empty?
      char = word[0]
      count = count_leading_character(word)
      if count == 1
        result += char
      else
        result += ( count.to_s + char )
      end
      count.times{ word.shift }
    end
    result
  end

  def self.count_leading_character(word)
    char = word[0]
    word = word.clone
    count = 0
    loop do
      if word[0] == char
        count += 1
      else
        break
      end
      word.shift
    end
    count
  end

  def self.is_num?(char)
    char.to_i.to_s == char
  end

  def self.leading_number(word)
    result = ""
    word = word.chars
    loop do
      break if !is_num?(word[0])
      result += word.shift
    end
    result.empty? ? "1" : result
  end

  def self.decode(word)
    result = ""
    until word.empty?
      leader = leading_number(word)
      count  = leader.to_i
      word.slice!(0, leader.length) unless count == 1
      current = word.slice!(0, 1)
      result += (current * count)
    end
    result
  end
end

class BookKeeping
  VERSION = 2
end