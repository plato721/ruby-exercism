class RunLengthEncoding
  def self.encode(word)
    return "" if word.empty?

    count = count_leading_character(word)
    result = count == 1 ? word[0] : "#{count}#{word[0]}"
    remainder = word.slice(count, word.size)

    result + encode(remainder)
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