module Luhn

open System.Text.RegularExpressions

let (|InvalidCharacter|) (n: string) = Regex.IsMatch(n, "[^0-9]")
let (|TooShort|) (n: string) = n.Length <= 1

let (|InvalidChecksum|) (n: string) =
    n
    |> fun n -> Regex.Replace(n, " ", "")
    |> Seq.rev
    |> Seq.map (string >> int)
    |> Seq.indexed
    |> Seq.sumBy
        (function
        | i, n when i % 2 = 0 -> n
        | _, n when n >= 5 -> 2 * n - 9
        | _, n -> 2 * n)
    |> (fun n -> n % 10)
    |> (<>) 0

let valid (number: string) : bool =

    number
    |> fun n -> Regex.Replace(n, " ", "")
    |> function
        | InvalidCharacter true
        | TooShort true
        | InvalidChecksum true -> false
        | _ -> true
