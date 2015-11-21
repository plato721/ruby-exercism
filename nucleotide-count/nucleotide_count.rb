class Nucleotide
  attr_reader :strand

  def self.from_dna(strand)
    self.new(strand)
  end

  def initialize(strand)
    raise ArgumentError if strand =~ /[^ATCG]+/
    @strand = strand
  end

  def histogram
    histogram = {"A"=>0, "T"=>0, "C"=>0, "G"=>0}
    strand.each_char.with_object(histogram) do |char, hash|
      hash[char] += 1
    end
  end

  def count(letter)
    self.strand.count(letter)
  end

  def inspect
    self.strand
  end
end