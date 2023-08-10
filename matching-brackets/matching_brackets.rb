class Brackets
  BRACKET_PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }

  def self.paired?(string)
    string.split("").inject(SimpleStack.new) do |stack, char|
      if is_left_bracket?(char)
        stack.push(char)
      elsif is_right_bracket?(char)
        return false unless get_right_bracket(stack.pop) == char
      end
      stack
    end.empty?
  end

  def self.get_right_bracket(left_bracket)
    BRACKET_PAIRS[left_bracket]
  end

  def self.is_left_bracket?(char)
    BRACKET_PAIRS.keys.include?(char)
  end

  def self.is_right_bracket?(char)
    BRACKET_PAIRS.values.include?(char)
  end
end

class SimpleStack
  def initialize
    @stack = []
  end

  def push(value)
    stack << value
  end

  def pop
    stack.pop
  end

  def empty?
    stack.empty?
  end

  private

  attr_reader :stack
end

