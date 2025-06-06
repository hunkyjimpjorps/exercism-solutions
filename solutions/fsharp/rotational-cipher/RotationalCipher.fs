module RotationalCipher

open System

let alphabet: char seq = { 'a' .. 'z' }

let generateKey (shift: int) : Map<char, char> =
    [ Seq.skip; Seq.take ]
    |> Seq.map (fun f -> f shift alphabet)
    |> Seq.concat
    |> Seq.zip alphabet
    |> Map

let (|LowerCase|_|) (c: char) =
    match Char.IsLower c with
    | true -> Some c
    | false -> None

let (|UpperCase|_|) (c: char) =
    match Char.IsUpper c with
    | true -> Char.ToLower c |> Some
    | false -> None

let rotate shiftKey text =
    let key = generateKey shiftKey

    text
    |> String.map (function
        | LowerCase c -> key[c]
        | UpperCase c -> key[c] |> Char.ToUpper
        | c -> c)
