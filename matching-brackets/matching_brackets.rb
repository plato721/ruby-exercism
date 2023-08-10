class Brackets
  BRACKET_PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }

  def self.paired?(string)
    stack = []
    string.split("").each do |char|
      next if !is_bracket?(char)

      if is_left_bracket?(char)
        stack << char
      else
        top = stack.pop
        return false if get_matching_bracket(top) != char
      end
    end
    stack.empty?
  end

  def self.is_bracket?(char)
    "[](){}".include?(char)
  end

  def self.get_matching_bracket(bracket)
    BRACKET_PAIRS[bracket]
  end

  def self.is_left_bracket?(char)
    BRACKET_PAIRS.keys.include?(char)
  end
end
