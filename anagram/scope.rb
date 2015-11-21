class Thing

  @@IDs = []
  ID_LETTERS = 2
  ID_NUMBERS = 5

  def initialize(name)
    @name =  name
    @id = get_id
  end

  def get_id
    begin
      id = create_id
      if @@IDs.include?(id)
        found = false
      else
        @@IDs << id
        found = true
      end
    end while found == false
    id
  end

  def create_id
    id = ""
    ID_LETTERS.times do 
      id << rand_letter
    end
    ID_NUMBERS.times do
      id << rand_number.to_s
    end
    id
  end

  def rand_letter
    ('A'..'Z').to_a.sample
  end

  def rand_number
    rand(10)
  end

  def scope_a(var1)
    some = var1
    5.times do
      some << rand_letter
    end
    puts "In scope a. Some is #{some}."
    bool = scope_b(some)
    puts "Back in scope a. Some is #{some}, but returning #{bool}."
    bool
  end

  def scope_b(var2)
    puts "In scope b. var2 is #{var2}."
    var2.downcase!
    puts "In scope b. var2 is now #{var2}."
    false
  end


end
