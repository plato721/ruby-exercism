class Sieve
  def initialize(max)
    @max = max
    @primes = []
    @sieve = initialize_sieve
  end

  def primes
    build_sieve
    apply_sieve
  end

  private

  def build_sieve
    loop do
      next_prime = get_next_prime
      break unless next_prime

      eliminate_multiples(next_prime)
    end
  end

  def eliminate_multiples(prime)
    @sieve[prime] = true
    next_non_prime = prime + prime

    loop do
      break if next_non_prime > @max

      @sieve[next_non_prime] = false
      next_non_prime += prime
    end
  end

  def apply_sieve
    [*0..@max].zip(@sieve)
              .select { |_potential_prime, is_prime| is_prime }
              .map { |prime, _is_prime| prime }
  end

  def get_next_prime
    @sieve.index("unknown")
  end

  def initialize_sieve
    [false, false] + [*2..@max].map { |_| "unknown" }
  end
end

#>> sieve = Sieve.new(10000)
#>> seive.primes
# => lots of primes... 9511, 9521, 9533, 9539, 9547, 9551, 9587, 9601, 9613, 9619, 9623, 9629, 9631, 9643, 9649, 9661, 9677, 9679, 9689, 9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767, 9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829, 9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887, 9901, 9907, 9923, 9929, 9931, 9941, 9949, 9967, 9973]
