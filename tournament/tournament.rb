class Tournament
  def self.tally(raw_results)
    tournament = new(raw_results)
    tournament.execute
  end

  def initialize(raw_results)
    @team_tallies = []
    @raw_results = raw_results
  end

  def execute
    compute_results
    sort_results
    print_results
  end

  private

  def compute_results
    @raw_results.split("\n").each { |row| calculate_team_tallies(row) }
  end

  def sort_results
    @team_tallies.sort!
  end

  def print_results
    "#{[headers, *@team_tallies].map(&:to_s).join("\n")}\n"
  end

  def calculate_team_tallies(row)
    team_a, team_b, result = row.split(';')
    calculate_team_tally(team_a, result)
    calculate_team_tally(team_b, flip_result(result))
  end

  def calculate_team_tally(team, result)
    current_tally = find_or_create_tally(team)
    current_tally.update_for(result)
  end

  def flip_result(result)
    return result if result == 'draw'

    result == 'win' ? 'loss' : 'win'
  end

  def find_or_create_tally(team)
    find_tally(team) || create_new_tally(team)
  end

  def find_tally(team)
    @team_tallies.find { |tally| tally.team == team }
  end

  def create_new_tally(team)
    TeamTally.new(team).tap { |tally| @team_tallies << tally }
  end

  def headers
    "Team                           | MP |  W |  D |  L |  P"
  end
end

class TeamTally
  attr_reader :team, :points, :matches_played, :wins, :losses, :draws

  WIN_POINTS = 3
  LOSS_POINTS = 0
  DRAW_POINTS = 1

  def initialize(team)
    @team = team
    @matches_played = 0
    @wins = 0
    @losses = 0
    @draws = 0
    @points = 0
  end

  def update_for(result)
    @matches_played += 1
    send("update_for_#{result}".to_sym)
  end

  def to_s
    "#{team.ljust(31, ' ')}|  #{matches_played} |  #{wins} |  #{draws} |  #{losses} |  #{points}"
  end

  def <=>(other)
    [-points, team] <=> [-other.points, other.team]
  end

  private

  def update_for_win
    @wins += 1
    @points += WIN_POINTS
  end

  def update_for_loss
    @losses += 1
    @points += LOSS_POINTS
  end

  def update_for_draw
    @draws += 1
    @points += DRAW_POINTS
  end
end
