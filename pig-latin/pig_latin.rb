module PigLatin
  def self.translate(phrase)
    phrase.split.map do |word|
      pattern = get_pattern(word)
      pattern_to_pig(word, pattern)
    end.join(" ")
  end

  def self.get_pattern(word)
    prefix_with_pattern.find do |regex, _|
      word.match(regex)
    end.pop
  end

  def self.prefix_with_pattern
    {
      /\A[ae]|yt|xr/ => 0,
      /\A[pkfr]|ye|xe/ => 1,
      /\A(qu|c|th[^r])/ => 2,
      /\A(squ|thr|sch)/ => 3
    }
  end

  def self.pattern_to_pig(word, pattern)
      (word.slice!(0, pattern) + "ay").prepend(word)
  end
end