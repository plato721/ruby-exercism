class SimpleCalculator
  class UnsupportedOperation < StandardError; end

  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class << self
    def calculate(first_operand, second_operand, operation)
      validate_arguments(first_operand, operation, second_operand)
      result = get_result(first_operand, operation, second_operand)
      get_result_text(first_operand, second_operand, operation, result)
    rescue ZeroDivisionError
      "Division by zero is not allowed."
    end

    private

    def validate_arguments(first_operand, operation, second_operand)
      raise ArgumentError unless valid_operands?(first_operand, second_operand)
      raise UnsupportedOperation unless valid_operation?(operation)
    end

    def valid_operands?(*operands)
      operands.all? { |o| valid_operand?(o) }
    end

    def valid_operand?(operand)
      operand.is_a?(Integer)
    end

    def valid_operation?(operation)
      ALLOWED_OPERATIONS.include?(operation)
    end

    def get_result(first_operand, operation, second_operand)
      first_operand.send(operation.to_sym, second_operand)
    end

    def get_result_text(first_operand, second_operand, operation, result)
      "#{first_operand} #{operation} #{second_operand} = #{result}"
    end
  end
end

