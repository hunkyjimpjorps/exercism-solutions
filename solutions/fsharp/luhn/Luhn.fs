module Luhn

open System.Text.RegularExpressions

let valid (number: string) =
    let numberTrimmed = Regex.Replace(number, " ", "")

    not (Regex.IsMatch(numberTrimmed, "[^0-9]"))
    && numberTrimmed.Length > 1
    && 0 = (numberTrimmed
            |> fun n -> Regex.Replace(n, " ", "")
            |> Seq.rev
            |> Seq.map (string >> int)
            |> Seq.indexed
            |> Seq.sumBy
                (function
                | i, n when i % 2 = 0 -> n
                | _, n when 2 * n > 9 -> 2 * n - 9
                | _, n -> 2 * n)
            |> (fun n -> n % 10))
