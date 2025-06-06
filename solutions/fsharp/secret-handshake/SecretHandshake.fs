module SecretHandshake

open System.Collections

let instructions =
    [| "wink"
       "double blink"
       "close your eyes"
       "jump" |]

let commands (number: int) =
    let bitsBA = BitArray([| number |])
    bitsBA.Length <- 5
    let bits = Array.create 5 true
    bitsBA.CopyTo(bits, 0)

    bits
    |> Array.take 4
    |> Array.zip instructions
    |> Array.where snd
    |> Array.map fst
    |> Array.toList
    |> match bits.[4] with
        | true -> List.rev
        | false -> id