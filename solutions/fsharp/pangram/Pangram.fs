module Pangram

let isPangram (input: string) : bool =
    String.filter (fun c -> System.Char.IsLetter c) input
    |> String.map (fun c -> System.Char.ToLower c)
    |> Seq.toList
    |> List.distinct
    |> List.length = 26
