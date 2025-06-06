module IsbnVerifier

open FsRegEx
open VerbalExpressions

let isbnRegExp =
    FsRegEx()
    |> add "^([0-9])-?([0-9]{3})-?([0-9]{5})-?([0-9X])$"

let isbnDigitVal (c: char) : int =
    match c with
    | 'X' -> 10
    | c -> int c - int '0'

let isbnChecksum (isbn: string) : int =
    FsRegEx()
    |> add "-"
    |> replace isbn ""
    |> Seq.toList
    |> List.map isbnDigitVal
    |> List.rev
    |> List.mapi (fun i n -> n * (i + 1))
    |> List.fold (+) 0

let isValid isbn =
    isMatch isbn isbnRegExp
    && isbnChecksum isbn % 11 = 0
