const protein_dictionary = Dict([
  "AUG" => "Methionine",
  "UUU" => "Phenylalanine",
  "UUC" => "Phenylalanine",
  "UUA" => "Leucine",
  "UUG" => "Leucine",
  "UCU" => "Serine",
  "UCC" => "Serine",
  "UCA" => "Serine",
  "UCG" => "Serine",
  "UAU" => "Tyrosine",
  "UAC" => "Tyrosine",
  "UGU" => "Cysteine",
  "UGC" => "Cysteine",
  "UGG" => "Tryptophan",
  "UAA" => "STOP",
  "UAG" => "STOP",
  "UGA" => "STOP"])

function proteins(strand)
  parse_proteins(Iterators.partition(strand, 3))
end

function parse_proteins(iter, acc=[])
  if isempty(iter)
    acc
  else
    codon, rest = Iterators.peel(iter)
    try
      protein = protein_dictionary[codon]
      if protein == "STOP"
        acc
      else
        parse_proteins(rest, [acc..., protein])
      end
    catch e
      throw(DomainError("$codon not found"))
    end

  end
end