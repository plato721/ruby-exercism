class ETL
  def self.transform(dirty)
    dirty.each_with_object({}) do |(point, letters), scrubbed|
      letters.each do |letter|
        scrubbed[letter.downcase] = point
      end  
    end
  end
end