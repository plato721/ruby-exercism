=begin
Write your code for the 'Resistor Color' exercise in this file. Make the tests in
`resistor_color_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/resistor-color` directory.
=end

class ResistorColor
  COLORS = %w[black brown red orange yellow green blue violet grey white]
  COLOR_CODE_MAP = COLORS.zip([*0...COLORS.length]).to_h

  def self.color_code(color)
    COLOR_CODE_MAP[color]
  end
end
