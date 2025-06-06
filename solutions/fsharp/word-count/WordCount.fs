module WordCount

open System.Text.RegularExpressions

let countWords (phrase: string) =
    phrase.ToLower()
    |> fun s -> Regex.Replace(s, "[^\w\s,']", "")
    |> fun s -> Regex.Replace(s, "[\s,]+", "\n")
    |> fun s -> Regex.Replace(s, "'(.+)'", "$1")
    |> fun s -> s.Split([| '\n' |])
    |> Seq.filter (fun s -> s.Equals("") |> not)
    |> Seq.countBy id
    |> Map.ofSeq
