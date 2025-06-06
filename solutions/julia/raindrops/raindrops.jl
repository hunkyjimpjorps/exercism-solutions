using OrderedCollections

drops = OrderedDict(3 => "Pling", 5 => "Plang", 7 => "Plong")

function raindrops(number)
    result = ""
    for dropfactor in keys(drops)
        if number % dropfactor == 0
            result = result * get(drops, dropfactor, "")
        end
    end
    if isempty(result)
        result = string(number)
    end
    return result
end
