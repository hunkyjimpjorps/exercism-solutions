function prime_factors(n)
    i = 2
    factors = Vector{Int}()

    while n > 1
        if n % i == 0
            push!(factors, i)
            n = n ÷ i
        else
            isodd(i) ? i += 2 : i += 1
        end
    end
    return factors
end
