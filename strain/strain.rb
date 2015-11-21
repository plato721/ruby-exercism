class Array

  def keep
    self.each.with_object([]) do |element, acc|
      acc << element if yield(element)
    end
  end

  def discard
    self.each.with_object([]) do |element, acc|
      acc << element if !(yield(element))
    end
  end
  
end