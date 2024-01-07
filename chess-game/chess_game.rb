module Chess
  FILES = 'A'..'H'
  RANKS = 1..8

  class << self
    def valid_square?(rank, file)
      valid_rank?(rank) && valid_file?(file)
    end

    def nick_name(first_name, last_name)
      "#{first_name[0..1]}#{last_name[-2..-1]}".upcase
    end

    def move_message(first_name, last_name, square)
      player = nick_name(first_name, last_name)
      valid_move = valid_square_mono?(square)
      valid_move ? valid_move_message(player, square) : invalid_move_message(player, square)
    end

    private

    def valid_rank?(rank)
      RANKS.include?(rank)
    end

    def valid_file?(file)
      FILES.include?(file)
    end

    def valid_square_mono?(mono_coords)
      file = get_file(mono_coords)
      rank = get_rank(mono_coords)
      valid_square?(file, rank)
    end

    def valid_move_message(player, square)
      "#{player} moved to #{square}"
    end

    def invalid_move_message(player, square)
      "#{player} attempted to move to #{square}, but that is not a valid square"
    end

    def get_file(mono_coords)
      mono_coords[1].to_i
    end

    def get_rank(mono_coords)
      mono_coords[0]
    end
  end
end
