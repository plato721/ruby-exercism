class Scale
  attr_reader :tonic, :type

  def initialize(tonic, type, intervals=nil)
    @tonic = tonic
    @type = type
    @intervals = intervals
  end

  def name
    self.tonic.capitalize + " " + self.type.to_s
  end


end