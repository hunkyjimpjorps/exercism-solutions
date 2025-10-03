function largest_product(str, span)
    if span > length(str)
        throw(ArgumentError("span cannot be longer than sequence"))
    elseif span < 0
        throw(ArgumentError("span width cannot be negative"))
    end
    digits = parse.(Int, collect(str))
    max([prod(digits[i:i+span-1]) for i in 1:(length(digits)-span+1)]...)
end