class RunLengthEncoding
  require 'pry'

  def self.encode(word)
    result = ""
    until word.empty?
      char = word[0]
      count = count_leading_character(word)
      count == 1 ? result += char : result += ( count.to_s + char )
      word.slice!(0,count)
    end
    result
  end

  def self.count_leading_character(word)
    char = word[0]
    word.match(/[#{char}]+/).to_s.size
  end

  def self.decode_single(code)
    matcher = code.match(/[\d]+/)
    matcher ? matcher.post_match * matcher[0].to_i : code
  end

  def self.decode(word)
    word.scan(/[\d]*[\D]{1}/)
        .map { |code| decode_single(code) }
        .join
  end
end

class BookKeeping
  VERSION = 2
end