class Brackets
  BRACKET_PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }

  class << self
    def paired?(expression)
      expression.split("").each_with_object(SimpleStack.new) do |current_char, bracket_stack|
        next unless is_bracket?(current_char)
        return false unless process_bracket(bracket_stack, current_char)
      end.empty?
    end

    private

    def process_bracket(bracket_stack, bracket)
      if is_left_bracket?(bracket)
        bracket_stack.push(bracket)
      elsif is_right_bracket?(bracket)
        left_bracket = bracket_stack.pop
        brackets_match?(left_bracket, bracket)
      end
    end

    def is_bracket?(char)
      is_left_bracket?(char) || is_right_bracket?(char)
    end

    def is_left_bracket?(char)
      BRACKET_PAIRS.keys.include?(char)
    end

    def is_right_bracket?(char)
      BRACKET_PAIRS.values.include?(char)
    end

    def get_right_bracket(left_bracket)
      BRACKET_PAIRS[left_bracket]
    end

    def brackets_match?(left, right)
      get_right_bracket(left) == right
    end
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

