module Complement

  def self.dna_rna_map(nucleotide)
      case nucleotide
      when 'G'
        'C'
      when 'C'
        'G'
      when 'T'
        'A'
      when 'A'
        'U'
      else
        raise ArgumentError
      end
  end

  def self.rna_dna_map(nucleotide)
    case nucleotide
    when 'G'
      'C'
    when 'C'
      'G'
    when 'A'
      'T'
    when 'U'
      'A'
    else
      raise ArgumentError
    end
  end

  def self.of_dna(dna)
    rna = String.new
      (0..(dna.length - 1)).each do |n|
        rna << dna_rna_map(dna[n])
    end
    rna
  end

  def self.of_rna(rna)
    dna = String.new
    (0..(rna.length - 1)).each do |n|
      dna << rna_dna_map(rna[n])
    end
    dna
  end
end
