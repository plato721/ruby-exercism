class Transpose
  def self.transpose(matrix)
    return "" if matrix == ""

    rows = matrix.split("\n")
    rows = pad(rows)
    rows.inject(Array.new {""}) do |transposed, row|
      row.split("").each_with_index { |char, i| (transposed[i] ||= "" ) << char }
      transposed
    end.join("\n")
  end

  def self.pad(rows)
    current_max = rows[-1].length
    rows.reverse.each_with_index do |row, i|
      rows[-i-1] = fill_row(rows[-i-1], current_max) if row.length < current_max
      current_max = row.length if row.length > current_max
    end
    rows
  end

  def self.fill_row(row, length)
    characters_needed = length - row.length
    row + " " * characters_needed
  end
end
