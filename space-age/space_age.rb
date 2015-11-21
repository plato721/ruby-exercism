class SpaceAge
  EARTH_SECS_PER_YEAR = 31557600
  EARTH_EQUIV_YEARS = {
    :on_mercury => 0.2408467,
    :on_venus => 0.61519726,
    :on_mars => 1.8808158,
    :on_jupiter => 11.862615,
    :on_saturn => 29.447498,
    :on_uranus => 84.016846,
    :on_neptune => 164.79132
  }

  def initialize(age_in_seconds)
    @age = age_in_seconds
  end

  def seconds
    @age
  end

  def on_earth
    @age.to_f / EARTH_SECS_PER_YEAR
  end

  def method_missing(method, *args)
    if method.to_s.start_with?("on_")
      on_earth / EARTH_EQUIV_YEARS[method]
    else
      super
    end
  end
  
end