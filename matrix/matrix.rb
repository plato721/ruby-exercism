class Matrix
  attr_reader :raw

  def initialize(arg)
    @raw = arg
  end

  def rows
    string_rows.map do |row|
      row.map { |e| e.to_i }
    end
  end

  def columns
    columns = empty_columns.each.with_index do |col, i|
      rows.each do |row|
        col << row[i]
      end
    end
  end

  private
  def empty_columns
    Array.new(rows.length){[]}
  end

  def string_rows
    self.raw.split("\n").map { |row| row.split(" ") }
  end
end