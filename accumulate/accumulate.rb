class Array
  def accumulate
    [*0...length].each_with_object([]) do |index, collection|
      collection << yield(self[index])
    end
  end
end