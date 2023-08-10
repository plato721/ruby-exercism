class Brackets
  BRACKET_PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }

  def self.paired?(string)
    string.split("").inject(SimpleStack.new) do |bracket_stack, current_char|
      if is_left_bracket?(current_char)
        bracket_stack.push(current_char)
      elsif is_right_bracket?(current_char)
        return false unless brackets_match(bracket_stack.pop, current_char)
      end
      bracket_stack
    end.empty?
  end

  def self.is_left_bracket?(char)
    BRACKET_PAIRS.keys.include?(char)
  end

  def self.is_right_bracket?(char)
    BRACKET_PAIRS.values.include?(char)
  end

  def self.get_right_bracket(left_bracket)
    BRACKET_PAIRS[left_bracket]
  end

  private

  def self.brackets_match(left, right)
    get_right_bracket(left) == right
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

