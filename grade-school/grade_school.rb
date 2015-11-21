class School
  def initialize
    @roster = {}
  end
  def add(name, grade)
    (@roster[grade] ||= []) << name
  end
  def grade(grade)
    @roster[grade] == nil ? [] : @roster[grade].sort
  end
  def to_hash
    Hash[@roster.sort.map{|key,value| [key, grade(key)]}]
  end
end
