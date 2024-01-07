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

    def card_range(card1, card2)
      case sum_cards(card1, card2)
      when 4..11 then "low"
      when 12..16 then "mid"
      when 17..20 then "high"
      when 21..21 then "blackjack"
      else "bust"
      end
    end

    def sum_cards(*cards)
      cards.sum { |c| parse_card(c) }
    end

    def first_turn(card1, card2, dealer_card)
      dealer_total = parse_card(dealer_card)
      range = card_range(card1, card2)
      send("#{range}_turn".to_sym, dealer_total)
    end

    def low_turn(_)
      "H"
    end

    def mid_turn(dealer_value)
      dealer_value > 6 ? "H" : "S"
    end

    def high_turn(_)
      "S"
    end

    def blackjack_turn(dealer_value)
      dealer_value == 11 ? "S" : "W"
    end

    def bust_turn(_)
      "P"
    end
  end
end
