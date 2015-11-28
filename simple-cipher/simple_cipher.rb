class Cipher
  def initialize(arg="aaaa")
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

  def decode_single(char, index)
    char.ord - key_at(index)
  end

  def encode_single(char, index)
    char.ord + key_at(index)
  end

  def key_at(index)
    key[index].ord - 'a'.ord
  end

  def key
    "dddddddddd"
  end
end