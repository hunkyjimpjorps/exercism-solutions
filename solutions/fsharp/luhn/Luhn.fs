module Luhn

open System.Text.RegularExpressions

let valid (number: string) =
    not (Regex.IsMatch(number, "[^0-9\s]"))
    && Regex.Replace(number, " ", "").Length > 1
    && 0 = (number
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
