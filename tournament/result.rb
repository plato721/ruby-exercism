class Result
  class << self
    def from_raw(raw)
      [first_result(raw), second_result(raw)]
    end

    def first_result(raw)
      raw_array = raw.split(';')
      team = raw_array.first
      result = raw_array.last
      new(team, result)
    end

    def second_result(raw)
      raw_array = raw.split(';')
      team = raw_array[1]
      result = flip_result(raw_array.last)
      new(team, result)
    end

    def flip_result(result)
      return 'loss' if result == 'win'
      return 'win' if result == 'loss'
      result
    end
  end

  attr_reader :team, :result

  def initialize(team, result)
    @team = team
    @result = result
  end
end