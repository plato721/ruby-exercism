class WordProblem
  attr_reader :statement

  @@OPERATION = {
    "plus" => :+,
    "minus" => :-,
    "multiplied" => :*,
    "divided" => :/
  }

  def initialize(statement)
    @statement = statement.delete('by')
    validate_statement
  end

  def validate_statement
    raise ArgumentError if numbers.count < 2
  end

  def answer
    numbers.count == 2 ? single_operation : double_operation
  end

  private
  def numbers
    statement.split.select do |str|
      str.to_i != 0
    end.map(&:to_i)
  end

  def operation_1
    statement.split[3]
  end

  def operation_2
    statement.split[5]
  end

  def single_operation
    numbers.inject(@@OPERATION[operation_1])
  end

  def double_operation
    result = numbers[0].send(@@OPERATION[operation_1], numbers[1])
    result.send(@@OPERATION[operation_2], numbers[2])
  end

end