module Blackjack
  class << self
    def parse_card(card)
      case card
      when "ace" then 11
      when "king", "queen", "jack"
        10
      when "ten" then 10
      when "nine" then 9
      when "eight" then 8
      when "seven" then 7
      when "six" then 6
      when "five" then 5
      when "four" then 4
      when "three" then 3
      when "two" then 2
      else
        0
      end
    end

    def card_range(card1, card2)
      raise "Please implement the Blackjack.card_range method"
    end

    def first_turn(card1, card2, dealer_card)
      raise "Please implement the Blackjack.first_turn method"
    end
  end
end
