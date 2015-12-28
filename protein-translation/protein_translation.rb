class Translation
  def self.of_codon(arg)
    codon_map[arg]
  end

  def self.codon_map
    {'AUG' => 'Methionine',
     'UUU' => 'Phenylalanine',
     'UUC' => 'Phenylalanine'}
  end
end