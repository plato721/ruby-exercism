class HighScores
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    high_to_low.first
  end

  def personal_top
    high_to_low.take(3)
  end

  def report
    "#{latest_score_message} #{last_score_ranking_message}"
  end

  def latest_score_message
    "Your latest score was #{latest}."
  end

  def last_score_ranking_message
    last_score_best? ? last_score_is_best_message : last_score_not_best_message
  end

  def last_score_is_best_message
    "That's your personal best!"
  end

  def last_score_not_best_message
    short_by = personal_best - latest
    "That's #{short_by} short of your personal best!"
  end

  def last_score_best?
    latest >= personal_best
  end

  private
  def high_to_low
    scores.sort{ |x, y| y <=> x }
  end
end