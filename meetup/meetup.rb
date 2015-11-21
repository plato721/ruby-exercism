class Meetup
  require 'date'

  attr_reader :month, :year

  DAY_MAP = {
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  ORDINAL_MAP = {
    :first => 1,
    :second => 2,
    :third => 3,
    :fourth => 4
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(day, week)
    first = week_start(week)
    last = first + 6
    day_in_week(day, (first..last))
  end

  private

  def week_start(week)
    return 13 if week == :teenth
    return last_full_week if week == :last
    (7 * ORDINAL_MAP[week]) - 6
  end

  def day_in_week(day, date_range)
    dates_for(date_range).find {|date| date.cwday == DAY_MAP[day]}
  end

  def dates_for(date_range)
    [*date_range].map {|date| Date.new(year, month, date) }
  end

  def last_full_week
    last_day = Date.civil(year, month, -1).day
    start = last_day - 6
  end

end