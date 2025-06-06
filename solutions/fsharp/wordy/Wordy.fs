module Wordy

open FParsec

type Operation =
    | Add
    | Subtract
    | Multiply
    | Divide

// parser primitives
let ws = spaces

let pBegin = skipString "What is"
let pEnd = skipString "?"

let pNumber = pint32

let pOperator =
    choice [ stringReturn "plus" Add
             stringReturn "minus" Subtract
             stringReturn "multiplied by" Multiply
             stringReturn "divided by" Divide ]

let pNextOp = (ws >>. pOperator) .>>. (ws >>. pNumber)

let pSentence =
    tuple2 (pBegin .>> ws >>. pNumber) (many pNextOp .>> pEnd)

// parsing function

let lookupFunc (f: Operation) : int -> int -> int =
    match f with
    | Add -> (+)
    | Subtract -> (-)
    | Multiply -> (*)
    | Divide -> (/)

let rec parseCaptures (c: int * (Operation * int) list) : int =
    match c with
    | acc, [] -> acc
    | acc, h :: t -> parseCaptures ((lookupFunc (fst h) acc (snd h)), t)

let answer (question: string) : int option =
    match run pSentence question with
    | Success (result, _, _) -> Some(parseCaptures result)
    | Failure (_) -> None
