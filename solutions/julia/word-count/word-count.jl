function wordcount(sentence)
  words = String.(filter(!isempty, strip.(split(lowercase(sentence), r"[^a-z0-9']+"), '\'')))
  reduce(build_bag, words, init=Dict())
end

function build_bag(acc, n)
  haskey(acc, n) ? acc[n] += 1 : acc[n] = 1
  acc
end