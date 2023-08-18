class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    validate_arguments(first_operand, operation, second_operand)
    result = get_result(first_operand, operation, second_operand)
    format_result(first_operand, second_operand, operation, result)
  rescue ZeroDivisionError
    "Division by zero is not allowed."
  end

  def self.valid_operands?(operands)
    operands.all? { |a| valid_operand?(a) }
  end

  def self.valid_operand?(operand)
    operand.is_a?(Integer)
  end

  def self.valid_operation?(operation)
    ALLOWED_OPERATIONS.include?(operation)
  end

  class UnsupportedOperation < StandardError
    def initialize(msg = nil)
      super
    end
  end

  private

  def self.format_result(first_operand, second_operand, operation, result)
    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end

  def self.get_result(first_operand, operation, second_operand)
    result = first_operand.to_i.send(operation.to_sym, second_operand.to_i)
  end

  def self.validate_arguments(first_operand, operation, second_operand)
    raise ArgumentError unless valid_operands?([first_operand, second_operand])
    raise UnsupportedOperation unless valid_operation?(operation)
  end
end

