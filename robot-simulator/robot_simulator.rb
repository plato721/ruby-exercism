class Simulator
  def instructions(args)
    args.chars.map {|char| instructions_map[char]}
  end

  def instructions_map
    {'L' => :turn_left,
     'R' => :turn_right,
     'A' => :advance
    }
  end

  def place(*args)
    robot = args.shift
    args = args.shift
    robot.at(args[:x], args[:y])
    robot.orient(args[:direction])
  end

  def evaluate(robot, short_commands)
    self.instructions(short_commands).each do |command|
      robot.send(command)
    end 
  end
end


class Robot
  attr_accessor :bearing, :x, :y

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

  def turn_right
    index = (legal_bearing.index(self.bearing) + 1) % 4
    self.orient(legal_bearing[index])
  end

  def turn_left
    index = (legal_bearing.index(self.bearing) - 1 + 4) % 4
    self.orient(legal_bearing[index])
  end

  def advance
    self.y += 1 if self.bearing == :north
    self.y -= 1 if self.bearing == :south
    self.x += 1 if self.bearing == :east
    self.x -= 1 if self.bearing == :west
  end

  def at(x, y)
    self.x = x
    self.y = y
  end

  def coordinates
    [self.x, self.y]
  end
end