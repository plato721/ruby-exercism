class Tournament
  class << self
    def tally(game_results)
      results = game_results.split("\n").flat_map { |raw| Result.from_raw(raw) }
      grouped_results = results.group_by { |result| result.team }
      tallied_results = tally_results(grouped_results)
      ordered_results = sort_results(tallied_results)
      print_results(ordered_results)
    end

    def tally_results(grouped_results)
      grouped_results.map do |team, results|
        ResultsTally.from_results(team, results)
      end
    end

    def print_results(tallies)
      tallies.map(&:to_s).unshift(headers).join("\n") + "\n"
    end

    def sort_results(tallies)
      tallies.sort_by { |tally| [-tally.points, tally.team_name] }
    end

    def headers
      "Team                           | MP |  W |  D |  L |  P"
    end
  end
end

class ResultsTally
  class << self
    def from_results(team_name, results)
      wins = count_wins(results)
      draws = count_draws(results)
      losses = count_losses(results)
      new(team_name, wins, draws, losses)
    end

    def count_wins(results)
      results.count { |result| result.win? }
    end

    def count_losses(results)
      results.count { |result| result.loss? }
    end

    def count_draws(results)
      results.count { |result| result.draw? }
    end
  end

  attr_reader :team_name, :wins, :draws, :losses

  def initialize(team_name, wins, draws, losses)
    @team_name = team_name
    @wins = wins
    @draws = draws
    @losses = losses
  end

  POINT_MAP = {
    win: 3,
    draw: 1,
    loss: 0
  }

  def points
    wins * POINT_MAP[:win] +
    draws * POINT_MAP[:draw] +
    losses * POINT_MAP[:loss]
  end

  def matches_played
    wins + losses + draws
  end

  def to_s
    "#{team_name.ljust(31, ' ')}|  #{matches_played} |  #{wins} |  #{draws} |  #{losses} |  #{points}"
  end
end

class Result
  class << self
    def from_raw(raw)
      [first_result(raw), second_result(raw)]
    end

    private
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

  attr_reader :team

  def initialize(team, result)
    @team = team
    @result = result
  end

  def win?
    result == "win"
  end

  def loss?
    result == "loss"
  end

  def draw?
    result == "draw"
  end

  private
  attr_reader :result
end
