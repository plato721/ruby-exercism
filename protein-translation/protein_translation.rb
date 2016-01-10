class Translation
  def self.of_codon(protein)
    codons_amino = codon_map.find do |codons, amino_acid|
      codons.include?(protein)
    end
    codons_amino ? codons_amino.last : invalid_codon
  end

  def self.invalid_codon
    raise InvalidCodonError, "Invalid codon."
  end

  def self.to_proteins(strand)
    strand.chars.each_slice(3).with_object([]) do |slice, proteins|
      proteins << Protein.new(slice.join)
    end
  end

  def self.of_rna(strand)
    proteins = to_proteins(strand).take_while { |codon| !codon.stop? }
    proteins.map(&:amino_acid)
  end

  def self.codon_map
    {['AUG'] => 'Methionine',
     ['UUU', 'UUC'] => 'Phenylalanine',
     ['UUA', 'UUG'] => 'Leucine',
     ['UCU', 'UCC', 'UCA', 'UCG'] => 'Serine',
     ['UAU', 'UAC'] => 'Tyrosine',
     ['UGU', 'UGC'] => 'Cysteine',
     ['UGG'] => 'Tryptophan',
     ['UAA', 'UAG', 'UGA'] => 'STOP'}
  end
end

class Protein
  attr_reader :codon, :amino_acid

  def initialize(codon)
    @codon = codon
    @amino_acid = Translation::of_codon(codon)
  end

  def stop?
    self.amino_acid == 'STOP'
  end
end

class InvalidCodonError < Exception
end
