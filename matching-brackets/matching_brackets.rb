class Brackets
  BRACKET_PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }

  class << self
    def paired?(expression)
      expression.split("").inject(SimpleStack.new) do |bracket_stack, current_char|
        if is_left_bracket?(current_char)
          bracket_stack.push(current_char)
        elsif is_right_bracket?(current_char)
          right_bracket_to_match = bracket_stack.pop
          return false unless brackets_match?(right_bracket_to_match, current_char)
        end
        bracket_stack
      end.empty?
    end

    private

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

