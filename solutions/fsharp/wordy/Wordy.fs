module Wordy

open FParsec

// parser primitives
let ws = spaces
let pBegin = skipString "What is" >>. ws
let pEnd = skipString "?"

let pNumber = pint32

// set up the OperatorPrecedenceParser
// which automatically parses alternating series of terms and operators
let pOpParser =
    new OperatorPrecedenceParser<int, unit, unit>()

pOpParser.TermParser <- pNumber .>> ws

// for each string, define an operator that
// - is delimited by spaces
// - has an associativity level of 1 (same level for all operators)
// - is left associative (all operations calculated from left to right)
[| "plus", (+)
   "minus", (-)
   "multiplied by", (*)
   "divided by", (/) |]
|> Array.iter (fun (s, op) -> pOpParser.AddOperator(InfixOperator(s, ws, 1, Associativity.Left, op)))

let pSentence =
    pBegin >>. pOpParser.ExpressionParser .>> pEnd

// parsing function
let answer (question: string) : int option =
    match run pSentence question with
    | Success (result, _, _) ->
        printfn $"Success: {question} was parsed as {result}"
        Some(result)
    | Failure (error, _, _) ->
        printfn $"Error: {error}"
        None
