class Isogram
  class << self
    def isogram?(word)
      word.split('').all? do |letter|
        appears_exactly_once?(letter, word) || is_repeatable?(letter)
      end
    end

    def appears_exactly_once?(letter, word)
      word.split('').count do |c|
        c.downcase == letter.downcase
      end == 1
    end

    def is_repeatable?(character)
      character.match(/[- ]/)
    end
  end
end
