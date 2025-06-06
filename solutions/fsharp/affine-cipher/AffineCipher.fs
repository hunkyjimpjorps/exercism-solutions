module AffineCipher

open System

let m: int = 26

let inline private (%%) (a: int) (b: int) : int = (a % b + b) % b

let private getIndex (ch: char) : int = int (Char.ToLower ch) - int 'a'

let private getLetter (i: int) : char = char (i + int 'a')

let private (|IsLetter|IsNumber|IsOther|) (ch: char) : Choice<unit, unit, unit> =
    if Char.IsAsciiLetter ch then IsLetter
    elif Char.IsAsciiDigit ch then IsNumber
    else IsOther

let private encodeChar (a: int) (b: int) (ch: char) : char option =
    match ch with
    | IsLetter ->
        ch
        |> getIndex
        |> (fun i -> (a * i + b) % m)
        |> getLetter
        |> Some
    | IsNumber -> Some ch
    | IsOther -> None

let private decodeChar (mmi: int) (b: int) (ch: char) : char option =
    match ch with
    | IsLetter ->
        ch
        |> getIndex
        |> (fun i -> (mmi * (i - b)) %% m)
        |> getLetter
        |> Some
    | IsNumber -> Some ch
    | IsOther -> None

let rec private egcd (a: int) (b: int) : int * int * int =
    match (a, b) with
    | (0, _) -> (b, 0, 1)
    | _ ->
        let (g, x, y) = egcd (b % a) a
        (g, y - (b / a) * x, x)

let encode (a: int) (b: int) (plainText: string) : string =
    match egcd a m with
    | (1, _, _) ->
        plainText
        |> Seq.choose (encodeChar a b)
        |> Seq.chunkBySize 5
        |> Seq.map String.Concat
        |> String.concat " "
    | _ -> invalidArg "a" $"MMI doesn't exist; a ({a}) and m ({m}) are not coprime"

let decode (a: int) (b: int) (cipheredText: string) : string =
    match egcd a m with
    | (1, x, _) ->
        cipheredText
        |> Seq.choose (decodeChar x b)
        |> String.Concat
    | _ -> invalidArg "a" $"MMI doesn't exist; a ({a}) and m ({m}) are not coprime"
