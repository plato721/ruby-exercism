class Transpose
  class << self
    def transpose(matrix)
      matrix = matrix.split("\n").map { |row| delimit_spaces(row.split("")) }
      matrix = pad_rows(matrix)
      matrix.transpose.map { |row| clean_and_join(row) }.join("\n")
    end

    def delimit_spaces(row)
      row.map { |char| char == " " ? "ACTUAL_SPACE" : char }
    end

    def clean_and_join(row)
      row.join("").rstrip.gsub("ACTUAL_SPACE", " ")
    end

    def pad_rows(rows)
      max_length_row = rows.max_by { |row| row.length }
      rows.map { |row| fill_row(row, max_length_row.length )}
    end

    def fill_row(row, length)
      characters_needed = length - row.length
      row + (" " * characters_needed).split("")
    end
  end
end
