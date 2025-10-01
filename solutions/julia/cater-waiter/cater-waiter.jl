function clean_ingredients(dish_name, dish_ingredients)
    (dish_name, Set(dish_ingredients))
end

function check_drinks(drink_name, drink_ingredients)
    isdisjoint(drink_ingredients, ALCOHOLS) ? "$drink_name Mocktail" : "$drink_name Cocktail"
end

function categorize_dish(dish_name, dish_ingredients)
    categories = ["VEGAN" => VEGAN, "VEGETARIAN" => VEGETARIAN, "PALEO" => PALEO, "KETO" => KETO, "OMNIVORE" => OMNIVORE]

    category = categories[findfirst(c -> dish_ingredients ⊆ c.second, categories)].first
    "$dish_name: $category"
end

function tag_special_ingredients(dish)
    name, ingredients = dish
    (name, SPECIAL_INGREDIENTS ∩ ingredients)
end

function compile_ingredients(dishes)
    union(dishes...)
end

function separate_appetizers(dishes, appetizers)
    setdiff(dishes, appetizers)
end

function singleton_ingredients(dishes, intersection)
    setdiff(compile_ingredients(dishes), intersection)
end