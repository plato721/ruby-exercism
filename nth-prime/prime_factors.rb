class PrimeFactors
  def self.for(cur_n, factors=[])
    #special case: cur_n is even:
    #  divide by 2 until it's not even anymore
    #  add 2 to prime factors list only once
    while cur_n.even?
      cur_n /= 2
      factors << 2 if !(factors.include?(2))
    end

    #test to see if there are any prime factors identified
    #  besides 2, because you are adding 2 to find next to
    #  check.
    if factors.length > 1
      test_factor = factors.last + 2
    else
      test_factor = 3
    end

    while (test_factor <= cur_n)
      if cur_n % test_factor == 0
        cur_n /= test_factor
        if Prime.is_prime?(test_factor) && !(factors.include?(test_factor))
          factors << test_factor
        end
        factors = self.of_n(cur_n, factors)
      end
      test_factor += 2
    end
    factors
  end
end

class Prime
  def self.nth(n)
    raise ArgumentError if n < 1
    primes_found = 0
    nth_prime = 1
    until primes_found == n
      nth_prime = next_prime(nth_prime)
      primes_found += 1
    end
    nth_prime
  end

  # finds next prime number greater than argument n
  def self.next_prime(n)
    next_prime = n + 1
    until is_prime?(next_prime)
      next_prime += 1
    end
    next_prime
  end
  
  def self.is_prime?(n)
    is_prime = true
    test_factor = 2
    while (test_factor < (n / 2 + 1)) && is_prime
      if n % test_factor == 0
        is_prime = false
      else
        test_factor += 1
      end
    end
    is_prime
  end

end


