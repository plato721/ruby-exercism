class RunLengthEncoding
  require 'pry'

  def self.encode(word)
    result = ""
    word = word.split("")
    until word.empty?
      char = word[0]
      count = count_leading_character(word)
      count == 1 ? result += char : result += ( count.to_s + char )
      count.times{ word.shift }
    end
    result
  end

  def self.count_leading_character(word)
    char = word[0]
    word = word.clone
    count = 0
    loop do
      word[0] == char ? count += 1 : break
      word.shift
    end
    count
  end

  def self.decode_single(code)
    matcher = code.match(/[\d]+/)
    return code if !matcher
    matcher.post_match * matcher[0].to_i
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