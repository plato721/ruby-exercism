class NilClass
  def reverse
    self
  end
end

class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(data, element)
    @datum = data
    @next = element
  end

  def reverse(prev_element=nil)
    cur_element = self.dup
    next_element = self.next
    cur_element.next = prev_element
    next_element.nil? ? cur_element : next_element.reverse(cur_element)
  end

  def self.to_a(element)
    element.nil? ? [] : [element.datum].concat(to_a(element.next))
  end

  def to_a
    Element.to_a(self)
  end

  def self.from_a(data)
    unattached = data.to_a.map { |datum| Element.new(datum, nil) }
    attached = unattached.each.with_index do |element, idx|
      element.next = unattached[idx + 1]
    end
    attached.first
  end
end
