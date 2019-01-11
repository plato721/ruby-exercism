class Isogram
  class << self
    def isogram?(word)
      word.split('').each_with_index do |character, index|
        next if allowed_to_duplicate?(character)

        rest = word[(index + 1)..-1]
        return false if rest.downcase.include?(character.downcase)
      end
    end

    def allowed_to_duplicate?(character)
      character.match(/[- ]/)
    end
  end
end
