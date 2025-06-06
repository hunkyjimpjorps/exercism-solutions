module PhoneNumber

open System
open FsRegEx

// Utility functions for railway-oriented programming model
// This lets us chain checks and processing steps together in a way that guarantees
// that the first error that's found carries through to the end
let bind switch =
    fun tracks ->
        match tracks with
        | Ok ok -> switch ok
        | Error err -> Error err

let (>>=) tracks switch = bind switch tracks

// Define all the individual check/processing steps, returning the Result type
let checkForLetter input =
    if isMatch @"[A-Za-z]" input then
        Error "letters not permitted"
    else
        Ok input

let checkForPunctuation input =
    if isMatch @"[@:!]" input then
        Error "punctuations not permitted"
    else
        Ok input

let stripPunctuation input = input |> replace @"[^\d]" "" |> Ok

let checkLength input =
    let l = String.length input

    match l with
    | 11 when input.[0] = '1' -> Ok input.[1..10]
    | 11 -> Error "11 digits must start with 1"
    | 10 -> Ok input
    | n when n < 10 -> Error "incorrect number of digits"
    | n when n > 11 -> Error "more than 11 digits"
    | _ -> Error "parsing error"

let checkAreaCode (input: string) =
    match input.[0] with
    | '0' -> Error "area code cannot start with zero"
    | '1' -> Error "area code cannot start with one"
    | _ -> Ok input

let checkExCode (input: string) =
    match input.[3] with
    | '0' -> Error "exchange code cannot start with zero"
    | '1' -> Error "exchange code cannot start with one"
    | _ -> Ok input

let parseNumber (input: string) = UInt64.Parse input |> Ok

// Now chain all our steps together
let clean (input: string) : Result<uint64, string> =
    input
    |> checkForLetter
    >>= checkForPunctuation
    >>= stripPunctuation
    >>= checkLength
    >>= checkAreaCode
    >>= checkExCode
    >>= parseNumber
