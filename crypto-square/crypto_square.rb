module CryptoEngine
  def self.clean(chunk)
    chunk.gsub(/[^\w]/, '').downcase
  end

  def self.square_edge_length(chunk)
    Math.sqrt(chunk.length).ceil
  end

  def self.segment(args)
    chunk = args[:chunk]
    size = args[:size]
    segments = chunk.split("").each_slice(size).with_object([]) do |slice, array|
      array << slice
    end.map {|segment| segment.join}
  end

  def self.rotate(args)
    segments = args[:segments]
    segments.each.with_object([]) do |segment, rotated|
      segment.each_char.with_index do |char, index|
        (rotated[index] ||= "") << char
      end
    end
  end

  def self.create_pattern(args)
    pile_count = args[:pile_count]
    stones = args[:stones]

    piles = Array.new(pile_count) { 0 }
    default_pile_stones = stones / pile_count
    leftover = stones % pile_count
    
    piles.map.with_index do |pile, index|
      index < leftover ? default_pile_stones + 1 : default_pile_stones
    end
  end

  def self.evenly_segment(args)
    chunk = args[:chunk]
    pattern = args[:pattern]
    pattern.each.with_object([]) do |word_length, message|
      message << chunk.slice!(0..word_length - 1)
    end
  end
end

class Crypto
  attr_reader :unencrypted, :cleaned, :size, :plaintext_segments

  def initialize(chunk)
    @unencrypted = chunk
    @cleaned = CryptoEngine.clean(unencrypted)
    @size = CryptoEngine.square_edge_length(cleaned)
    @plaintext_segments = 
      CryptoEngine.segment(chunk: self.cleaned,
                            size: self.size)
  end

  def normalize_plaintext
    cleaned
  end

  def ciphertext
    rotated = CryptoEngine.rotate(segments: self.plaintext_segments,
                                      size: self.size)
    rotated.join
  end

  def normalize_ciphertext
    pattern = CryptoEngine.create_pattern(pile_count: self.size,
                                              stones: ciphertext.length)
    segmented = CryptoEngine.evenly_segment(chunk: ciphertext,
                                          pattern: pattern)
    segmented.join(" ")
  end



end
