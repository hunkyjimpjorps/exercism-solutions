const allergens = ["eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"]
const allergen_count = length(allergens)
const max_score = 2^allergen_count

function allergic_to(score, allergen)
    allergen ∈ allergy_list(score)
end

function allergy_list(score)
    Set(allergens[BitArray(digits(score % max_score, base=2, pad=allergen_count))])
end
