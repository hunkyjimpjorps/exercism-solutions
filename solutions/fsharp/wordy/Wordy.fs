module Wordy

open FParsec

type Operation = int -> int -> int
type OperationNode = Operation * int

// parser primitives
let ws = spaces

let pBegin = skipString "What is"
let pEnd = skipString "?"

let pNumber = pint32

let pOperator =
    choice [ stringReturn "plus" (+)
             stringReturn "minus" (-)
             stringReturn "multiplied by" (*)
             stringReturn "divided by" (/) ]

let pNextOp = (ws >>. pOperator) .>>. (ws >>. pNumber)

let pSentence =
    tuple2 (pBegin .>> ws >>. pNumber) (many pNextOp .>> pEnd)

// parsing function

let rec parseCaptures =
    function
    | acc, [] -> acc
    | acc, h : OperationNode :: t ->
        (fst h) acc (snd h)
        |> (fun f -> parseCaptures (f, t))

let answer (question: string) : int option =
    match run pSentence question with
    | Success (result, _, _) -> Some(parseCaptures result)
    | Failure (_) -> None
