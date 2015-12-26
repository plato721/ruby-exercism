class CustomSet
  attr_reader :set

  def initialize(arg)
    @set = create_set(arg)
  end

  def create_set(arg)
    arg.uniq.sort
  end

  def ==(other)
    self.set == other.set
  end
end