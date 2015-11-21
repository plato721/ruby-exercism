class PrimeFactors
  def self.for(cur_n, factors=[])
    #special case: cur_n is even:
    #  divide by 2 until it's not even anymore
    while cur_n.even?
      cur_n /= 2
      factors << 2 
    end

    test_factor = 3
    while (test_factor <= cur_n)
      while cur_n % test_factor == 0
        cur_n /= test_factor
        if Prime.is_prime?(test_factor)
          factors << test_factor
        end
      end
      test_factor += 2
    end
    factors
  end
end

class Prime  
  def self.is_prime?(n)
    is_prime = true
    return true if n == 2
    test_factor = 3
    while (test_factor < (Math.sqrt(n).ceil)) && is_prime
      if n % test_factor == 0
        is_prime = false
      else
        test_factor += 2
      end
    end
    is_prime
  end
end


