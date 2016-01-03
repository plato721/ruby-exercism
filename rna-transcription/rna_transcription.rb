module Complement

  DNA_RNA = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  RNA_DNA = DNA_RNA.invert

  def self.dna_rna_map(nucleotide)
    validate_dna(nucleotide)
    DNA_RNA[nucleotide]
  end

  def self.rna_dna_map(nucleotide)
    validate_rna(nucleotide)
    RNA_DNA[nucleotide]
  end

  def self.validate_rna(nucleotide)
    if RNA_DNA[nucleotide].nil?
      raise ArgumentError, "Invalid RNA nucleotide"
    end
  end

  def self.validate_dna(nucleotide)
    if DNA_RNA[nucleotide].nil?
      raise ArgumentError, "Invalid DNA nucleotide"
    end
  end

  def self.of_dna(dna)
    dna.chars.map do |char|
      dna_rna_map(char)
    end.join
  end

  def self.of_rna(rna)
    rna.chars.map do |char|
      rna_dna_map(char)
    end.join
  end
end
