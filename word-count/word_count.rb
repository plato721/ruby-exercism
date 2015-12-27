class Phrase
  def initialize(phrase)
    @phrase = phrase
  end
  def word_count
    words = @phrase.downcase.split(/[ \n,]/)
    words.each_with_object(Hash.new(0)) do |word, words_count|
      scrubbed_word = word.match(/[\w']+/).to_s
      words_count[scrubbed_word] += 1 if scrubbed_word.length > 0
    end
  end
end