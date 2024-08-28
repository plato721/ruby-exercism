=begin
Write your code for the 'Alphametics' exercise in this file. Make the tests in
`alphametics_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/alphametics` directory.
=end
class Alphametics
  def self.solve(puzzle)
    adder = Adder.new(puzzle)
    adder.get_solution
  end

  # Creates an array of length number_digits starting at [0, 0, ..., 0]
  # #increment will then count up to the max of [9, 9, ..., 9], returning
  # false when it is out of range
  class Adder
    attr_reader :cur_map

    def initialize(puzzle)
      @puzzle = puzzle
    end

    def get_solution
      @letters = get_letters(@puzzle)

      components = @puzzle.split(/\W+/)
      @leading_letters = get_leading_letters(components)

      compute_solution
    end

    def compute_solution
      letter_possibles = @letters.map do |l|
        if @leading_letters.include?(l)
          [*"#{l}1".."#{l}9"]
        else
          [*"#{l}0".."#{l}9"]
        end
      end

      solution_group = letter_possibles[1..-1].inject(letter_possibles[0]) do |all_possibles, one_letter_possibles|
        all_possibles.product(one_letter_possibles)
      end.find do |possibles_group|
        possibles_group = possibles_group.flatten
        possibles_group.uniq { |pg| pg[-1] } == possibles_group &&
          solution?(possibles_group)
      end

      return {} unless solution_group

      group_to_solution(solution_group.flatten.sort)
    end

    def solution?(possibles_group)
      cur_map = group_to_solution(possibles_group)
      Tester.solution?(@puzzle, cur_map)
    end

    def get_letters(puzzle)
      puzzle.split(/\W+/).join.split('').uniq.sort
    end

    def get_leading_letters(components)
      components.map { |word| word[0] }
    end

    def group_to_solution(possibles_group)
      possibles_group.map do |possibles_pair|
        [possibles_pair[0], possibles_pair[1].to_i]
      end.to_h
    end
  end

  class Tester
    def self.solution?(puzzle, mapping)
      components = puzzle.split(/\W+/)
      goal = components.pop
      addends = components
      left_side = addends.inject(0) do |acc, word|
        acc + word_to_int(word, mapping)
      end
      right_side = word_to_int(goal, mapping)
      left_side == right_side
    end

    def self.word_to_int(word, mapping)
      word.split('').reduce('') do |acc, letter|
        acc << mapping[letter].to_s
      end.to_i
    end
  end

end
