class Phrase
  attr_reader :phrase

  def initialize(phrase)
    @phrase = phrase
  end

  def to_words(phrase)
    phrase.downcase.split(/[ \n,]/)
  end

  def scrub_words(words)
    words.select { |word| word =~ word_matcher }
    .map { |word| word.match(word_matcher).to_s }
  end

  def word_count
    words = to_words(self.phrase)
    scrub_words(words).each_with_object(Hash.new(0)) do |word, words_count|
      words_count[word] += 1
    end
  end

  private
  def word_matcher
    /[\w']+/
  end
end