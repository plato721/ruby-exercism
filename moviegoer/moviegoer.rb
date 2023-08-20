class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  ADULT_AGE = 18
  PRICE = 15
  SENIOR_AGE = 60
  SENIOR_DISCOUNT = 5

  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    senior? ? senior_price : PRICE
  end

  private def senior?
    age >= SENIOR_AGE
  end

  private def senior_price
    PRICE - SENIOR_DISCOUNT
  end

  def watch_scary_movie?
    adult?
  end

  private def adult?
    age >= ADULT_AGE
  end

  def claim_free_popcorn!
    member? ? "🍿" : raise(NotMovieClubMemberError, "No 🍿 for you.")
  end

  def member?
    member
  end

  private

  attr_reader :age, :member
end
