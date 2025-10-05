function detect_anagrams(subject, candidates)
  filter(c -> lowercase(c) != lowercase(subject) && sort(collect(lowercase(c))) == sort(collect(lowercase(subject))), candidates)
end
