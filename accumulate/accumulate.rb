class Array
  def accumulate
    acc = []
    self.length.times do |idx|
      acc << yield(self[idx])
    end
    acc
  end
end