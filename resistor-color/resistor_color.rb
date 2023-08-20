class ResistorColor
  COLORS = %w[black brown red orange yellow green blue violet grey white]
  COLOR_CODE_MAP = COLORS.zip([*0...COLORS.length]).to_h

  def self.color_code(color)
    COLOR_CODE_MAP[color]
  end
end
