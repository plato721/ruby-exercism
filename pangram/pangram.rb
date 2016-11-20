class Pangram
  def self.is_pangram?(phrase)
    test_phrase = phrase.downcase
    alphas.all? { |char| test_phrase.include?(char) }
  end

  private
  def self.alphas
    [*'a'..'z']
  end
end

module BookKeeping
  VERSION = 2
end