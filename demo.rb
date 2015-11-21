class HelloWorld
  def self.helloworld(name="World")
    puts "Hello #{name}!"
  end
  def initialize(name="World", location)
    @name = name
    @location = location
  end
  def hello
    puts "Hello #{@name}! (from instance method)"
  end

end

HelloWorld.helloworld
