module ProteinTranslation

type Codon = C of string
type Protein =
    | STOP
    | P of string

let codonMap : Map<Codon, Protein> =
    [ C "AUG", P "Methionine"
      C "UUU", P "Phenylalanine"
      C "UUC", P "Phenylalanine"
      C "UUA", P "Leucine"
      C "UUG", P "Leucine"
      C "UCU", P "Serine"
      C "UCC", P "Serine"
      C "UCA", P "Serine"
      C "UCG", P "Serine"
      C "UAU", P "Tyrosine"
      C "UAC", P "Tyrosine"
      C "UGU", P "Cysteine"
      C "UGC", P "Cysteine"
      C "UGG", P "Tryptophan"
      C "UAA", STOP
      C "UAG", STOP
      C "UGA", STOP ]
    |> Map.ofList

let proteins (rna: string) : string list =
    let rec parseCodons (s: string) : Codon list =
        match s.[0..2] with
        | "" -> []
        | sSub -> C sSub :: (parseCodons s.[3..])

    let rec identifyCodons (s: Codon list) : string list =
        match s with
        | [] -> []
        | head :: tail ->
            match codonMap.TryFind(head) with
            | Some codon ->
                match codon with
                | STOP -> []
                | P codon -> codon :: (identifyCodons tail)
            | None -> invalidArg "codon" "Invalid codon"

    identifyCodons (parseCodons rna)
