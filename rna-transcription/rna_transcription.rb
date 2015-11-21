module Complement

  DNA_RNA = {
    :G => :C,
    :C => :G,
    :T => :A,
    :A => :U
  }

  RNA_DNA = DNA_RNA.invert

  def self.dna_rna_map(nucleotide)
    raise ArgumentError if DNA_RNA[nucleotide.to_sym].nil?
    DNA_RNA[nucleotide.to_sym].to_s
  end

  def self.rna_dna_map(nucleotide)
    raise ArgumentError if RNA_DNA[nucleotide.to_sym].nil?
    RNA_DNA[nucleotide.to_sym].to_s
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
