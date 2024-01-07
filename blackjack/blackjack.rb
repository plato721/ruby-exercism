module Blackjack
  class << self
    def parse_card(card)
      case card
      when "ace" then 11
      when "king", "queen", "jack", "ten" then 10
      when "nine" then 9
      when "eight" then 8
      when "seven" then 7
      when "six" then 6
      when "five" then 5
      when "four" then 4
      when "three" then 3
      when "two" then 2
      else 0
      end
    end

    def sum_cards(*cards)
      cards.sum { |c| parse_card(c) }
    end

    def card_range(card1, card2)
      case sum_cards(card1, card2)
      when 4..11 then "low"
      when 12..16 then "mid"
      when 17..20 then "high"
      else "blackjack"
      end
    end

    def first_turn(card1, card2, dealer_card)
      total = sum_cards(card1, card2)
      dealer_total = sum_cards(dealer_card)
      range = card_range(card1, card2)
      case
      when total == 22 then "P"
      when range == "high" then "S"
      when range == "mid" && dealer_total > 6 then "H"
      when range == "mid" then "S"
      when range == "low" then "H"
      when total == 21 && dealer_total == 11 then "S"
      else "W"
      end
    end
  end
end
