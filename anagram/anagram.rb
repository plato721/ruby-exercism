class Anagram
  attr_reader :length, :word

  def initialize(word)
    @word = word
    @length = @word.length
  end

  def match(possibles)
    possibles.select { |possible| anagram?(possible) }
  end

  def anagram?(check_word)
    if check_word.length == self.length && !(identical?(check_word))
      normalize(check_word) == normalize(self.word)
    end
  end

  def normalize(word)
    word.downcase.chars.sort.join
  end

  def identical?(check_word)
    check_word.downcase == @word.downcase
  end
end