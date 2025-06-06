module Wordy

open FParsec

type Operation = int -> int -> int
type OperationNode = Operation * int
type OperationTail = OperationNode list

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
    | (acc: int), (op, x): OperationNode :: t ->
        op acc x
        |> (fun result -> parseCaptures (result, t))

let answer (question: string) : int option =
    match run pSentence question with
    | Success (result, _, _) -> Some(parseCaptures result)
    | Failure (_) -> None
