module WordCount

open System.Text.RegularExpressions

let countWords (phrase: string) =
    phrase.ToLower()
    |> fun s -> Regex.Matches(s, "\w+(?:'\w+)?")
    |> Seq.countBy (fun m -> m.Value)
    |> Map.ofSeq
