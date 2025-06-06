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

let pOpParser =
    new OperatorPrecedenceParser<int, unit, unit>()

pOpParser.TermParser <- pNumber .>> ws

[| "plus", (+)
   "minus", (-)
   "multiplied by", (*)
   "divided by", (/) |]
|> Array.iter (fun (s, op) -> pOpParser.AddOperator(InfixOperator(s, ws, 1, Associativity.Left, op)))

let pSentence =
    pBegin >>. ws >>. pOpParser.ExpressionParser .>> pEnd

// parsing function
let answer (question: string) : int option =
    match run pSentence question with
    | Success (result, _, _) -> 
        printfn $"Success: {question} was parsed as {result}"
        Some(result)
    | Failure (error, _, _) -> 
        printfn $"Error: {error}"
        None
