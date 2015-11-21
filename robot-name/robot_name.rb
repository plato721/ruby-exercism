class Robot
  attr_reader :name

  CHARS_IN_NAME = 2
  DIGITS_IN_NAME = 3

  @@all_names = []

  def initialize
    @name = generate_name
    @@all_names << @name
  end
  
  def reset
    @name = generate_name
  end

  private
  def generate_name
    begin
      name = String.new
      CHARS_IN_NAME.times { name << ('A'..'Z').to_a.sample }
      DIGITS_IN_NAME.times { name << rand(0..9).to_s }
    end while @@all_names.include?(name)
    name
  end
end
