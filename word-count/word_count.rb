class Phrase
  def initialize(phrase)
    @phrase = phrase
    @word_count = Hash.new(0)
  end
  def word_count
    @word_count.clear
    words = []
    words = @phrase.downcase.split(/[ \n,]/)
    words.each do |word|
      scrubbed_word = word.match(/[\w']+/).to_s
      @word_count[scrubbed_word] += 1 if scrubbed_word.length > 0
    end
    @word_count
  end
end