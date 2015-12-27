class Phrase
  attr_reader :phrase

  def initialize(phrase)
    @phrase = phrase
  end

  def to_words(phrase)
    phrase.downcase.split(/[ \n,]/)
  end

  def word_count
    words = to_words(self.phrase)
    words.each_with_object(Hash.new(0)) do |word, words_count|
      scrubbed_word = word.match(/[\w']+/).to_s
      words_count[scrubbed_word] += 1 if scrubbed_word.length > 0
    end
  end
end