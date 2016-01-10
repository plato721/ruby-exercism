class Array
  def accumulate
    self.each_with_object([]) do |element, collection|
      collection << yield(element)
    end
  end
end
