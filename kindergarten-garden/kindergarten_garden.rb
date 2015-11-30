class Garden
  attr_reader :garden, :students

  def initialize(info, students=[*'a'..'z'])
    @garden = garden_init(info)
    @students = students_init(students)
  end

  def plant_map
    { 'R' => :radishes,
      'C' => :clover,
      'G' => :grass,
      'V' => :violets }
  end

  def garden_init(info)
    string_rows = info.split("\n")
    [ string_rows[0].chars, string_rows[1].chars ]
  end

  def students_init(students)
    students.sort.map { |student| student[0].downcase }
  end

  def codes_at(child_num)
    first_plant = child_num * 2
    [ self.garden.first[first_plant], self.garden.first[first_plant + 1],
      self.garden.last[first_plant], self.garden.last[first_plant + 1] ]
  end

  def position_for(name)
    students.index(name.to_s.downcase[0])
  end

  def method_missing(m)
    codes_at(position_for(m)).map { |code| plant_map[code] }
  end

end