class Triangle
  attr_reader :num_rows, :rows

  def initialize(num_rows)
    @num_rows = num_rows
    @rows = compute_rows
  end

  def compute_rows
    [*1..num_rows].each_with_object([]) do |row_num, rows|
      rows << row(row_num)
    end
  end

  def row(n)
    return [1] if n == 1
    return [1, 1] if n == 2
    next_row(row(n - 1))
  end

  def next_row(row)
    [*0..row.length - 2].each_with_object([1]) do |idx, new_row|
      new_row << row[idx] + row[idx + 1]
    end << 1
  end
end
