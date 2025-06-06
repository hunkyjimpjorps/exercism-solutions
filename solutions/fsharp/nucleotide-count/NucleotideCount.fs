module NucleotideCount

open System.Text.RegularExpressions
open FSharpPlus

let (|HasInvalidNucleotides|_|) strand =
    if Regex.Match(strand, "[^ACGT]").Success then
        Some()
    else
        None

let nucleotideCounts (strand: string) : Option<Map<char, int>> =
    let emptyMap =
        [ 'A'; 'C'; 'G'; 'T' ]
        |> List.map (fun c -> (c, 0))
        |> Map.ofList

    match strand with
    | HasInvalidNucleotides -> None
    | s ->
        s
        |> Seq.toList
        |> List.countBy id
        |> Map.ofList
        |> Map.unionWith (+) emptyMap
        |> Some
