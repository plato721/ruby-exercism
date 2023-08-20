class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  ADULT_MIN_AGE = 18
  SENIOR_DISCOUNT_MIN_AGE = 60
  STANDARD_TICKET_PRICE = 15
  DISCOUNT_TICKET_PRICE = 10

  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    senior? ? DISCOUNT_TICKET_PRICE : STANDARD_TICKET_PRICE
  end

  private def senior?
    age >= SENIOR_DISCOUNT_MIN_AGE
  end

  def watch_scary_movie?
    adult?
  end

  private def adult?
    age >= ADULT_MIN_AGE
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
