function pythagorean_triplets(x::Int)
    triplets = Tuple{Int,Int,Int}[]
    a_max = isqrt(x^2 + 1)

    for a = 1:a_max 
        b_max = isqrt(x^2 - a^2) + 1
        for b = (a + 1):b_max
            c = (x - a - b)
            if a^2 + b^2 == c^2 
                push!(triplets, (a, b, c))
            end
        end
    end
    
    return triplets
end
