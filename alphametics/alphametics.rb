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

  def leading_zeros?(mapping)
    @leading_letters.any? { |l| mapping[l].zero? }
  end

  def unique_codes?(solution)
    solution.values.sort == solution.values.uniq.sort
  end

  class Adder
    attr_reader :digits

    BASE = 10

    def initialize(number_digits)
      @number_digits = number_digits
      @digits = [*1..number_digits].map { 0 }
    end

    def increment
      (@number_digits - 1).downto(0).each do |place|
        if @digits[place] + 1 < BASE
          @digits[place] += 1
          return @digits
        else
          @digits[place] = 0
        end
      end
      false # out of range -- got through all the possibilities
    end
  end
end
