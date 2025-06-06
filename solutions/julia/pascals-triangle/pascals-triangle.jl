function triangle(maxN)
    if maxN < 0
        throw(DomainError(maxN, "Pascal's triangle undefined for negative rows"))
    end
    
    allRows = Vector{Int64}[]
    for n in 1:maxN
        row = Int64[]
        for k in 1:n
            push!(row, binomial(n - 1, k - 1))
        end
        push!(allRows, row)
    end
    allRows
end