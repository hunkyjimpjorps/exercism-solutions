module Acronym

open FsRegEx
open FSharpx

let abbreviate phrase =
    phrase
    |> replace "[.,_]" ""
    |> replace "(\\s-\\s|-|\\s+)" " "
    |> String.splitChar [| ' ' |]
    |> Array.map (Seq.head >> string)
    |> System.String.Concat
    |> String.toUpper
