module Etl

let rearrangeKey (k: int * char list) : (char * int) list =
    let score, letterList = k

    letterList
    |> List.map (fun l -> (System.Char.ToLower l, score))

let transform (scoresWithLetters: Map<int, char list>) =
    scoresWithLetters
    |> Map.toList
    |> List.map rearrangeKey
    |> List.concat
    |> Map.ofList
