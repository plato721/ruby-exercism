class Series
  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence.chars.map(&:to_i)
  end

  def slice_valid?(length)
    length <= sequence.length
  end

  def validate_slice(length)
    if !slice_valid?(length)
      raise ArgumentError,
        "Must choose slice at most length of sequence (#{sequence.length})"
    end
  end

  def largest_product(length)
    validate_slice(length)
    return 1 if self.sequence.empty?
    sequence.each_cons(length).with_object([]) do |slice, products|
      products << slice.inject(:*)
    end.max
  end
end
