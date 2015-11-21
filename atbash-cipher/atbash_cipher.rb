class Atbash
  def self.encoding_map
    map ||= [*:a..:z].zip([*:a..:z].reverse).to_h
  end

  def self.encode_letter(char)
    return char if char.match(/[\d]/)
    encoding_map[char.to_sym]
  end

  def self.encode(msg)
    cleaned = sanitize(msg)
    encoded = msg.downcase.chars.map{ |char| encode_letter(char) }.join
    enspace(encoded)
  end

  def self.enspace(msg)
    spaced = []
    msg.chars.each_slice(5) do |slice|
      spaced << slice.push(" ")
    end
    spaced.flatten.join.chop
  end

  def self.sanitize(msg)
    msg.gsub(/[^a..zA..Z0..9]/, "")
  end
end
