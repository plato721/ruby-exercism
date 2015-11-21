class Acronym
  VERSION = 1

  def self.abbreviate(what)
    phrase = spaces_for_punctuation(what)
    phrase = normalize_caps(phrase)
    take_caps(phrase)
  end

  def self.spaces_for_punctuation(phrase)
    phrase.gsub(/[-:,]/,' ')
  end

  def self.normalize_caps(phrase)
    phrase = phrase.split(' ').each do |word|
      word[0] = word[0].upcase
      word.capitalize! if word =~ /[A-Z]{2,}/
    end.join
  end

  def self.take_caps(phrase)
    phrase.chars.map do |char|
      char.upcase == char ? char : ''
    end.join.gsub(/\s+/, '')
  end

end