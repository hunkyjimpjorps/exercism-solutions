dna_to_rna = Dict('G' => 'C',
                  'C' => 'G',
                  'T' => 'A',
                  'A' => 'U')

function to_rna(dna)
    try
        string((dna_to_rna[c] for c in dna)...)
    catch 
        throw(ErrorException("Invalid DNA base"))
    end
end
