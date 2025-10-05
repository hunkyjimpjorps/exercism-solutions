normalize = sort ∘ collect ∘ lowercase

function detect_anagrams(subject, candidates)
  filter(c -> lowercase(c) != lowercase(subject) && normalize(c) == normalize(subject), candidates)
end
