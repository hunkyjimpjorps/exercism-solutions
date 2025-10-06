function sum_of_multiples(limit, factors)
  isempty(factors) ? 0 : sum(union([iszero(f) ? (0:0) : (0:f:limit-1) for f in factors]...))
end