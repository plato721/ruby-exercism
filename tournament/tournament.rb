class Tournament
  def self.tally(game_results)
    tournament = new(game_results)
    tournament.execute
  end

  def initialize(game_results)
    @team_tallies = []
    @game_results = game_results
  end

  def execute
    compute_results
    sort_results
    print_results
  end

  private

  def compute_results
    @game_results.split("\n").each { |row| calculate_team_tallies(row) }
  end

  def calculate_team_tallies(row)
    team_a, team_b, result = row.split(';')
    calculate_team_tally(team_a, result)
    calculate_team_tally(team_b, flip_result(result))
  end

  def calculate_team_tally(team, result)
    current_tally = get_tally(team)
    current_tally[:matches_played] += 1
    if result == "win"
      current_tally[:wins] += 1
      current_tally[:points] += 3
    elsif result == "loss"
      current_tally[:losses] += 1
    elsif result == "draw"
      current_tally[:draws] += 1
      current_tally[:points] += 1
    end
  end

  def get_tally(team)
    tally = @team_tallies.find { |tally| tally[:team] == team }
    return tally if tally

    new_tally = base_team_tally.clone
    new_tally[:team] = team
    @team_tallies << new_tally
    new_tally
  end

  def flip_result(result)
    return result if result == 'draw'

    result == 'win' ? 'loss' : 'win'
  end

  def base_team_tally
    {
      team: nil,
      matches_played: 0,
      wins: 0,
      draws: 0,
      losses: 0,
      points: 0
    }
  end

  def print_results
    return headers + "\n" if @team_tallies.empty?
    [headers, print_team_tallies].join("\n") + "\n"
  end

  def sort_results
    @team_tallies.sort_by! { |tally| [-tally[:points], tally[:team]] }
  end

  def headers
    "Team                           | MP |  W |  D |  L |  P"
  end

  def print_team_tallies
    @team_tallies.map { |tally| print_tally(tally) }.join("\n")
  end

  def print_tally(tally)
    "#{tally[:team].ljust(31, ' ')}|  #{tally[:matches_played]} |  #{tally[:wins]} |  #{tally[:draws]} |  #{tally[:losses]} |  #{tally[:points]}"
  end
end
