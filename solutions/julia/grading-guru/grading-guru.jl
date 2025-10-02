function demote(n)
  n isa Float64 ? UInt8(ceil(n)) :
  n isa Integer ? Int8(n) :
  throw(MethodError(demote, (n,)))
end

function preprocess(coll)
  coll isa Vector ? map(demote, reverse(coll)) :
  coll isa Set ? sort(map(demote, collect(coll)), rev=true) :
  throw(MethodError(preprocess, (coll,)))
end
