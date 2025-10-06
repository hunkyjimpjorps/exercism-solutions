function sum_of_multiples(limit, factors)
  isempty(factors) ? 0 : sum(union([multiples(limit, f) for f in factors]...))
end

function multiples(limit, factor)
  iszero(factor) ? (0:0) : (0:factor:limit-1) 
end