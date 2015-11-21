class Sieve
  attr_reader :primes

  def initialize(max)
    @max = max
    @primes = []
    @sieve = Array.new(@max)
    seed
    populate
  end

  private
  def populate
    loop do
      next_prime != nil ? @primes << next_prime : break
      sieve(@primes.last)
    end
  end
  def sieve(prime)
    @sieve.each_index { |i| @sieve[i] = i if i % prime == 0 }
  end
  def next_prime
    @sieve.index(nil)
  end
  def seed
    @sieve[0] = 0 # 0 and 1 need to be marked so they aren't
    @sieve[1] = 1 #   discovered as primes.
  end
end

#>> sieve = Sieve.new(10000)
#>> seive.primes
# => lots of primes... 9511, 9521, 9533, 9539, 9547, 9551, 9587, 9601, 9613, 9619, 9623, 9629, 9631, 9643, 9649, 9661, 9677, 9679, 9689, 9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767, 9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829, 9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887, 9901, 9907, 9923, 9929, 9931, 9941, 9949, 9967, 9973]