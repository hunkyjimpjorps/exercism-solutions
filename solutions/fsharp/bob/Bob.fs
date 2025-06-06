module Bob

open System.Text.RegularExpressions

let makeOption n = if n then Some() else None

let (|EndsIn|_|) (mark: string) (statement: string) = statement.EndsWith(mark) |> makeOption

let (|IsAllCaps|_|) (statement: string) =
    (statement.ToUpper() = statement
     && Regex.Match(statement, "[a-zA-Z]").Success)
    |> makeOption

let (|IsNothing|_|) (statement: string) = statement = "" |> makeOption

let response (input: string) : string =
    match input.Trim() with
    | IsNothing -> "Fine. Be that way!"
    | IsAllCaps & EndsIn "?" -> "Calm down, I know what I'm doing!"
    | IsAllCaps -> "Whoa, chill out!"
    | EndsIn "?" -> "Sure."
    | _ -> "Whatever."
