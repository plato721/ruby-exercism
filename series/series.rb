class Series
  def initialize(word)
    @word = word
  end
  def slices(length)
    raise ArgumentError, "Slice too long" if length > @word.length
    nums_array = @word.chars.map {|char| char.to_i}
    nums_array.each_cons(length).with_object(return_array=[]) {|x| return_array << x }
  end
end
