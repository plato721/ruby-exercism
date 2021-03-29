class ResistorColorDuo
  COLORS_VALUES = %w[
    black
    brown
    red
    orange
    yellow
    green
    blue
    violet
    grey
    white
  ].zip([*"0".."9"]).to_h

  def self.value(colors)
    colors.inject("") do |total, color|
      total + COLORS_VALUES[color]
    end[0..1].to_i
  end
end
