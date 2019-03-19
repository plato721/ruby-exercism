# Determines if a word or phrase is an isogram.
# An isogram is a word or phrase without repeating characters,
# insensitve of case, ignoring hyphens or spaces.
class Isogram
  class << self
    def isogram?(word)
      normalized = word.scan(/[\w]/)
      normalized.uniq(&:downcase).length == normalized.length
    end
  end
end
