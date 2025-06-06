module ParallelLetterFrequency

open FSharpPlus
open System.Text.RegularExpressions

let asyncParse (text: string) =
    async {
        return
            text.ToLower()
            |> (fun t -> Regex.Replace(t, "[\s.,'0-9]", ""))
            |> Seq.countBy id
    }

let frequency (texts: string list) =
    texts
    |> Seq.map asyncParse
    |> Async.Parallel
    |> Async.RunSynchronously
    |> Seq.map Map.ofSeq
    |> Seq.fold (fun acc m -> Map.unionWith (+) acc m) Map.empty
