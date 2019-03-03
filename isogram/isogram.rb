class Isogram
  class << self
    def isogram?(word)
      word.split('').all? do |letter|
        appears_exactly_once?(letter, word) || is_repeatable?(letter)
      end
    end

    def appears_exactly_once?(letter, word)
      count_letter_in_word(letter, word) == 1
    end

    def count_letter_in_word(letter, word)
      word.split('').count do |c|
        c.downcase == letter.downcase
      end
    end

    def is_repeatable?(character)
      character.match(/[- ]/)
    end
  end
end
