module Pangram

let isPangram (input: string) : bool =
    String.filter System.Char.IsLetter input
    |> String.map System.Char.ToLower
    |> Seq.toList
    |> List.distinct
    |> List.length = 26
