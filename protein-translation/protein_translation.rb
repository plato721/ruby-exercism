class Translation
  def self.of_codon(protein)
    check_codon(protein)
    codon_map[protein]
  end

  def self.check_codon(protein)
    if !(codon_map.keys.include?(protein))
      raise InvalidCodonError, "Invalid codon."
    end
  end

  def self.lowest_stop(proteins)
    proteins.each_with_index do |protein, index|
      return index if protein.stop?
    end
    nil
  end

  def self.to_proteins(strand)
    strand.chars.each_slice(3).with_object([]) do |slice, proteins|
      proteins << Protein.new(slice.join)
    end
  end

  def self.apply_stop(proteins)
    stop_idx = lowest_stop(proteins)
    stop_idx ? proteins.slice(0, stop_idx) : proteins
  end

  def self.of_rna(strand)
    proteins = to_proteins(strand)
    proteins = apply_stop(proteins)
    proteins.map(&:amino_acid)
  end

  def self.codon_map
    {'AUG' => 'Methionine',
     'UUU' => 'Phenylalanine',
     'UUC' => 'Phenylalanine',
     'UUA' => 'Leucine',
     'UUG' => 'Leucine',
     'UCU' => 'Serine',
     'UCC' => 'Serine',
     'UCA' => 'Serine',
     'UCG' => 'Serine',
     'UAU' => 'Tyrosine',
     'UAC' => 'Tyrosine',
     'UGU' => 'Cysteine',
     'UGC' => 'Cysteine',
     'UGG' => 'Tryptophan',
     'UAA' => 'STOP',
     'UAG' => 'STOP',
     'UGA' => 'STOP' }
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