class Scrabble
  attr_reader :word

  def self.score(word)
    Scrabble.new(word).score
  end

  SCORE = {
    ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'] => 1,
    ['D', 'G'] => 2,
    ['B', 'C', 'M', 'P'] => 3,
    ['F', 'H', 'V', 'W', 'Y'] => 4,
    ['K'] => 5,
    ['J', 'X'] => 8,
    ['Q', 'Z'] => 10
    }

  def initialize(word)
    @word = word
  end

  def score
    return 0 if untestable?
    word.chars.map { |letter| score_letter(letter) }.reduce(:+)
  end

  def untestable?
    word.nil? || (word.match(/[\s]+/)) || word.empty?
  end

  def score_letter(char)
    SCORE.select do |letters, _|
      letters.include?(char.upcase)
    end.values.first
  end

end