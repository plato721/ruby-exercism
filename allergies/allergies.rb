class Allergies
  attr_reader :score

  def initialize(score)
    @score = score % 256
  end

  def allergies
    ["cats", "pollen", "chocolate", "tomatoes", "strawberries", "shellfish",
      "peanuts", "eggs"]
  end

  def allergic_to?(allergen)
    list.include?(allergen)
  end

  def list(score = self.score)
    list ||= mask(score).zip(allergies).map do |scored, masked|
      scored && masked
    end.flatten.compact.reverse
  end

  def mask(score)
    mask ||= score.to_s(2).rjust(8,'0').chars.map do |bit|
      bit == '1' ? true : nil
    end
  end
end