class Hexadecimal
  attr_reader :hex, :hexmap

  def initialize(hex)
    @hex = hex
    @hexmap = build_hexmap
  end

  def build_hexmap
    lowers = [*'0'..'9'].zip([*0..9]).to_h
    uppers = [*'a'..'f'].zip([*10..15]).to_h
    lowers.merge(uppers)
  end

  def to_decimal
    return 0 if hex =~ /[^\h]/
    hex.chars.reverse.map.with_index do |char, idx|
      16 ** idx * hexmap[char]
    end.inject(:+)
  end

end