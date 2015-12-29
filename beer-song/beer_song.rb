class BeerSong
  def verse(verse_num)
    return verse_typical(verse_num) if verse_num > 2
    return verse_two if verse_num == 2
    return verse_one if verse_num == 1
    return verse_zero if verse_num == 0
    raise ArgumentError, "Bad verse number"
  end

  def verses(verse_high, verse_low)
    play_order = [*verse_low..verse_high].reverse
    play_order.inject("") do |acc, verse|
      acc << verse(verse) + "\n"
    end
  end

  def sing
    verses(99,0)
  end

  private
  def verse_typical(verse_num)
<<-EOM
#{verse_num} bottles of beer on the wall, #{verse_num} bottles of beer.
Take one down and pass it around, #{verse_num - 1} bottles of beer on the wall.
EOM
  end
  def verse_two
<<-EOM
2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.
EOM
  end
  def verse_one
<<-EOM
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
EOM
  end
  def verse_zero
<<-EOM
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
EOM
  end
end