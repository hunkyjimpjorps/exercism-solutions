function keep(values, predicate)
  values[predicate.(values)]
end

function discard(values, predicate)
  values[.!predicate.(values)]
end
