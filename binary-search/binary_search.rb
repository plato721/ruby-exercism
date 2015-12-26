class BinarySearch
  attr_reader :list
  attr_accessor :current_list

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
    location = search(num: num, lower: 0, upper: list.length - 1)
    location ? location : not_found
  end

  def not_found
    raise "The search value is not in the list"
  end


  def lower_options(args)
    mid = (args[:lower] + args[:upper]) / 2
    args[:upper] = mid - 1
    return nil if args[:upper] < args[:lower]
    args
  end

  def upper_options(args)
    mid = (args[:lower] + args[:upper]) / 2
    args[:lower] = mid + 1
    return nil if args[:lower] > args[:upper]
    args
  end

  def get_search_options(args)
    mid = (args[:lower] + args[:upper]) / 2
    return lower_options(args) if args[:num] < list[mid]
    return upper_options(args) if args[:num] > list[mid]
  end

  def search(args)
    mid = (args[:lower] + args[:upper]) / 2
    return mid if list[mid] == args[:num]
    new_options = get_search_options(args)
    return nil if !new_options
    search(new_options)
  end


  def sorted?(array)
    array.sort == array
  end

  # Totally worthless function
  def middle
    midpoint = list.length / 2
  end
end