=begin
Write your code for the 'Alphametics' exercise in this file. Make the tests in
`alphametics_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/alphametics` directory.
=end
class Alphametics
  def self.solve(puzzle)
    tester = get_tester(puzzle)
    letters = get_letters(puzzle)
    adder = Adder.new(letters.length)
    cur_map = letters.zip(adder.digits).to_h

    loop do
      if tester.solution?(cur_map)
        return cur_map
      else
        cur_codes = adder.increment
        return {} unless cur_codes

        cur_map = letters.zip(cur_codes).to_h
      end
    end
  end

  # yeah, this doesn't really work as such, but it's just a visual marker that only .solve is
  # the public interface
  private

  def self.get_letters(puzzle)
    puzzle.split(/\W+/).join.split('').uniq.sort
  end

  def self.get_tester(puzzle)
    components = puzzle.split(/\W+/)
    new(components)
  end

  def initialize(components)
    @leading_letters = get_leading_letters(components)
    @goal = components.pop
    @addends = components
  end

  def get_leading_letters(components)
    components.map { |word| word[0] }
  end

  def solution?(mapping)
    return false unless valid?(mapping)

    left_side = @addends.inject(0) do |acc, word|
      acc += word_to_int(word, mapping)
    end
    right_side = word_to_int(@goal, mapping)

    left_side == right_side
  end

  def word_to_int(word, mapping)
    word.split('').reduce('') do |acc, letter|
      acc << mapping[letter].to_s
    end.to_i
  end

  def valid?(mapping)
    unique_codes?(mapping) && !leading_zeros?(mapping)
  end

  # The start of a word can't be a zero
  def leading_zeros?(mapping)
    @leading_letters.any? { |l| mapping[l].zero? }
  end

  # Each value 0 - 9 can only be assigned to one letter at a time
  def unique_codes?(solution)
    solution.values.sort == solution.values.uniq.sort
  end

  # Creates an array of length number_digits starting at [0, 0, ..., 0]
  # #increment will then count up to the max of [9, 9, ..., 9], returning
  # false when it is out of range
  class Adder
    attr_reader :digits

    def initialize(number_digits)
      @number_digits = number_digits
      @digits = [*1..number_digits].map { 0 }
      @sum = 0
    end

    def increment
      @sum += 1
      digits = @sum.to_s

      # out of range -- got through all the possibilities
      return false unless digits.length <= @number_digits

      @digits = digits.rjust(@number_digits, '0')
                      .split('').map(&:to_i)
    end
  end
end
