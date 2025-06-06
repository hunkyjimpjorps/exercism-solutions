function comparefactors(n, op)
    if n <= zero(n) 
        throw(DomainError("Not a natural number"))
    else 
        aliquot = sum([i for i in 1:(n ÷ 2) if n % i == 0])
        op(n, aliquot)
    end
end

function isperfect(n)
    comparefactors(n, (==))
end

function isabundant(n)
    comparefactors(n, (<))
end

function isdeficient(n)
    comparefactors(n, (>))
end
