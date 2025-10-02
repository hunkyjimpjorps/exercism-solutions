function demote(n)
  n isa Float64 ? UInt8(ceil(n)) :
  n isa Integer ? Int8(n) :
  throw(MethodError(demote, (n,)))
end

function preprocess(coll)
  coll isa Vector ? demote.(reverse(coll)) :
  coll isa Set ? sort(demote.(collect(coll)), rev=true) :
  throw(MethodError(preprocess, (coll,)))
end
