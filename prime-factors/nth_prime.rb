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
