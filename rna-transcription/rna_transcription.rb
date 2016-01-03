module Complement

  DNA_RNA = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  RNA_DNA = DNA_RNA.invert

  def self.invalid_rna(nucleotide)
    raise ArgumentError, "#{nucleotide} is not a valid RNA nucleotide"
  end

  def self.invalid_dna(nucleotide)
    raise ArgumentError, "#{nucleotide} is not a valid DNA nucleotide"
  end

  def self.of_dna(dna)
    dna.chars.map do |char|
      DNA_RNA.fetch(char) { |nucleotide| invalid_dna }
    end.join
  end

  def self.of_rna(rna)
    rna.chars.map do |char|
      RNA_DNA.fetch(char) { |nucleotide| invalid_rna }
    end.join
  end
end
