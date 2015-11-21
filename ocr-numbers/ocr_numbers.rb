class OCR
  attr_reader :text

  def ocr_map
    { [" _ ", "| |", "|_|"] => "0",
      ["   ", "  |", "  |"] => "1",
      [" _ ", " _|", "|_ "] => "2",
      [" _ ", " _|", " _|"] => "3",
      ["   ", "|_|", "  |"] => "4",
      [" _ ", "|_ ", " _|"] => "5",
      [" _ ", "|_ ", "|_|"] => "6",
      [" _ ", "  |", "  |"] => "7",
      [" _ ", "|_|", "|_|"] => "8",
      [" _ ", "|_|", " _|"] => "9",
      ["xxx", "xxx", "xxx"] => ","}
  end

  def initialize(text)
    @text = text
  end

  def convert
    with_breaks = insert_breaks(text)
    lines = to_lines(with_breaks)
    to_big(lines).map { |big| ocr_map[big] || "?" }.join.chop
  end

  private
  def insert_breaks(text)
    text.gsub("\n", "xxx\n")
  end

  def to_lines(text = self.text)
    lines = ["", "", "", ""]
    text.split("\n").each_with_index do |line, idx|
      lines[idx % 4] << line
    end
    lines.take(3)
  end

  def to_big(lines)
    lines.each_with_object([]) do |line, big_chars|
      line.chars.each_slice(3).with_index do |layer, idx|
        (big_chars[idx] ||= []) << layer.join
      end
    end
  end
end