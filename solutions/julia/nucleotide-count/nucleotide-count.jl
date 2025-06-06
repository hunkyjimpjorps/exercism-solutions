"""
    count_nucleotides(strand)

The frequency of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    baseDict = Dict('A' => 0,
                    'C' => 0,
                    'G' => 0,
                    'T' => 0)
    for base in strand
        if haskey(baseDict, base)
            baseDict[base] += 1
        else
            throw(DomainError(base, "Invalid DNA base abbreviation"))
        end
    end
    baseDict 
end
