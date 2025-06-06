module Luhn

open System.Text.RegularExpressions

let makeActivePattern =
    function
    | true -> Some()
    | false -> None

let (|InvalidCharacter|_|) (n: string) =
    Regex.IsMatch(n, "[^0-9]") |> makeActivePattern

let (|TooShort|_|) (n: string) = n.Length <= 1 |> makeActivePattern

let (|InvalidChecksum|_|) (n: string) =
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
    |> makeActivePattern

let valid (number: string) : bool =
    number
    |> fun n -> Regex.Replace(n, " ", "")
    |> function
        | InvalidCharacter
        | TooShort
        | InvalidChecksum -> false
        | _ -> true
