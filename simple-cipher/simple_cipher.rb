class Cipher
  attr_reader :key

  def initialize(key = nil)
    check_key(key) if !key.nil?
    @key = key || init_key
  end

  def encode(plain)
    plain.chars.map.with_index do |char, index|
      encode_single(char, index).chr
    end.join
  end

  def decode(cipher)
    cipher.chars.map.with_index do |char, index|
      decode_single(char, index).chr
    end.join
  end

  private
  def check_key(key)
    bad_key if key.empty?
    key.chars.each do |char|
      bad_key if !(char =~ /[a-z]{1}/)
    end
  end

  def bad_key
    raise ArgumentError, "Key must be all lowercase letters"
  end

  def decode_single(char, index)
    raw = char.ord - key_at(index)
    raw < 'a'.ord ? raw += 26 : raw 
  end

  def encode_single(char, index)
    (char.ord - 'a'.ord + key_at(index)) % 26 + 'a'.ord
  end

  def key_at(index)
    key[index].ord - 'a'.ord
  end

  def init_key
    [*1..10].map { random_character }.join
  end

  def random_character
    [*'a'..'z'].sample
  end
end