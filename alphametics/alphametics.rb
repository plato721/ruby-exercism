=begin
Write your code for the 'Alphametics' exercise in this file. Make the tests in
`alphametics_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/alphametics` directory.
=end
class Alphametics
  def self.solve(puzzle)
    adder = Adder.new(puzzle)
    tester = Tester.new(puzzle)

    loop do
      return {} unless adder.compute_next_map

      if tester.solution?(adder.cur_map)
        return adder.cur_map
      end
    end
  end

  # Creates an array of length number_digits starting at [0, 0, ..., 0]
  # #increment will then count up to the max of [9, 9, ..., 9], returning
  # false when it is out of range
  class Adder
    attr_reader :cur_map

    def initialize(puzzle)
      @letters = get_letters(puzzle)
      @cur_value_indexes = @letters.map { 0 }

      components = puzzle.split(/\W+/)
      @leading_letters = get_leading_letters(components)
      @value_wheels = get_value_wheels
      @max_indexes = get_max_indexes
    end

    def get_max_indexes
      @value_wheels.map { |wheel| wheel.length - 1 }
    end

    def compute_next_map
      if @cur_map.nil?
        @cur_map = get_map
        return true if unique_codes?
      end

      @wheel_index ||= @letters.length - 1
      loop do
        if @cur_value_indexes[@wheel_index] + 1 <= @max_indexes[@wheel_index]
          @cur_value_indexes[@wheel_index] += 1
          @cur_map = get_map
          return true if unique_codes?
        else
          loop do
            @cur_value_indexes[@wheel_index] = 0
            @wheel_index -= 1
            return false if @wheel_index < 0

            if @cur_value_indexes[@wheel_index] + 1 <= @max_indexes[@wheel_index]
              @cur_value_indexes[@wheel_index] += 1
              @wheel_index = @letters.length - 1 # reset to point to right most wheel
              @cur_map = get_map
              return true if unique_codes?
              break
            end

          end

        end
      end

      # we've gone through the wheels - nothing more to increment
      return false
    end

    def get_map
      @letters.map.with_index do |letter, i|
        possibles_for_letter = @value_wheels[i]
        current_letter_position = @cur_value_indexes[i]
        current_letter_value = possibles_for_letter[current_letter_position]
        [letter, current_letter_value]
      end.to_h
    end

    def get_value_wheels
      values = @letters.map do |l|
        if @leading_letters.include?(l)
          [*1..9]
        else
          [*0..9]
        end
      end
    end

    def get_letters(puzzle)
      puzzle.split(/\W+/).join.split('').uniq.sort
    end

    def get_leading_letters(components)
      components.map { |word| word[0] }
    end

    # Each value 0 - 9 can only be assigned to one letter at a time
    def unique_codes?
      @cur_map.values.sort == @cur_map.values.uniq.sort
    end
  end

  class Tester
    def initialize(puzzle)
      components = puzzle.split(/\W+/)
      @goal = components.pop
      @addends = components
    end

    def solution?(mapping)
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
  end

end
