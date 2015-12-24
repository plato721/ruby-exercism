class Robot
  attr_accessor :bearing

  def legal_bearing
    [:north, :east, :south, :west]
  end

  def validate_bearing(dir)
    if !legal_bearing.include? dir
      raise ArgumentError, "Must orient in one of #{legal_bearing}"
    end
  end

  def orient(dir)
    validate_bearing(dir)
    self.bearing = dir
  end

end