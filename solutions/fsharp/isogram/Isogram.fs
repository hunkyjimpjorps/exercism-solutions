module Isogram

open System.Text.RegularExpressions

let isIsogram (str: string) =
    let cleanedStr =
        Regex.Replace(str, "[-\s]", "").ToLower()

    cleanedStr |> Seq.distinct |> Seq.length = cleanedStr.Length
