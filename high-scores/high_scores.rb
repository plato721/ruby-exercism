class HighScores
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top
    scores.max(3)
  end

  def latest_best?
    latest >= personal_best
  end

  def best_difference
    personal_best - latest
  end

  def report
    Report.new(self).run_report
  end
end

class Report
  attr_reader :high_scores

  def initialize(scoreable)
    @high_scores = scoreable
  end

  def run_report
    "#{latest_score_msg} #{personal_best_msg}"
  end

  def latest_score_msg
    "Your latest score was #{high_scores.latest}."
  end

  def personal_best_msg
    high_scores.latest_best? ? met_personal_best_msg : short_personal_best_msg
  end

  def met_personal_best_msg
    "That's your personal best!"
  end

  def short_personal_best_msg
    "That's #{high_scores.best_difference} short of your personal best!"
  end
end
