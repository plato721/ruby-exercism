class Phrase
  attr_reader :phrase

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    split_phrase.each_with_object(Hash.new(0)) do |word, result|
      result[word.split] += 1
    end
  end

  def split_phrase
    if phrase.include?(',')
      phrase.split(',')
    else
      phrase.split(' ')
    end
  end
end