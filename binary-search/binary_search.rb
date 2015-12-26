class BinarySearch
  attr_reader :list

  def initialize(list)
    check_sorted(list)
    @list = list
  end

  def check_sorted(list)
    if !sorted?(list)
      raise ArgumentError, "Must provide a sorted list"
    end
  end

  def search_for(num)
    location = search(num)
    location ? location : not_found
  end

  def not_found
    raise "The search value is not in the list"
  end

  def search(num, list = self.list)
    # first = list.first
    # last = list.last
    # mid = (first + last) / 2
    # return mid if list[mid] == num
    # return search(num, list.slice(first, mid - 1)) if list[mid] > num
    # return search(num, list.slice(mid + 1, last)) if list[mid] < num
    nil
  end


  def sorted?(array)
    array.sort == array
  end
end