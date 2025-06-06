module Series
open System

let (|InvalidWindow|) ((str: string), length) : bool = length <= 0 || length > str.Length

let slices (str: string) length =
    match (str, length) with
    | InvalidWindow true -> None
    | _ ->
        str
        |> Seq.windowed length
        |> Seq.map (fun xs -> String.Concat(xs))
        |> Seq.toList
        |> Some
