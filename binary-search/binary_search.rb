class BinarySearch
  def initialize(arg)
    check_sorted(arg)
  end

  def check_sorted(arg)
    if !sorted?(arg)
      raise ArgumentError, "Must provide a sorted array"
    end
  end

  def sorted?(array)
    array.sort == array
  end

  def list
    [1, 3, 4, 6, 8, 9, 11]
  end
end