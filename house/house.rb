class House
  def self.initial_lines
    ["This is the horse and the hound and the horn\n",
    "This is the farmer sowing his corn\n",
    "This is the rooster that crowed in the morn\n",
    "This is the priest all shaven and shorn\n",
    "This is the man all tattered and torn\n",
    "This is the maiden all forlorn\n",
    "This is the cow with the crumpled horn\n",
    "This is the dog\n",
    "This is the cat\n",
    "This is the rat\n",
    "This is the malt\n",
    "This is the house that Jack built.\n\n"]
  end

  def self.subsequent_lines
    ["that belonged to the farmer sowing his corn\n",
    "that kept the rooster that crowed in the morn\n",
    "that woke the priest all shaven and shorn\n",
    "that married the man all tattered and torn\n",
    "that kissed the maiden all forlorn\n",
    "that milked the cow with the crumpled horn\n",
    "that tossed the dog\n",
    "that worried the cat\n",
    "that killed the rat\n",
    "that ate the malt\n",
    "that lay in the house that Jack built.\n\n"]
  end

  def self.verse(idx)
    initial_lines.reverse[idx] + subsequent_lines.last(idx).join
  end

  def self.recite
    (0...initial_lines.length).each.with_object("") do |idx, rhyme|
      rhyme << verse(idx)
    end.chop
  end
end