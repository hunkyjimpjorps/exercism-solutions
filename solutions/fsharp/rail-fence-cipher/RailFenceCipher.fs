module RailFenceCipher

let template rails =
    seq {
        while true do
            yield! [| 0 .. rails - 1 |]
            yield! [| rails - 2 .. -1 .. 1 |]
    }

let encode (rails: int) (message: string) =
    Seq.zip (template rails) message
    |> Seq.sortBy fst
    |> Seq.map snd
    |> System.String.Concat

let decode rails (message: string) =
    Seq.zip (template rails) [| 1 .. message.Length |]
    |> Seq.sortBy fst
    |> Seq.zip message
    |> Seq.sortBy (snd >> snd)
    |> Seq.map fst 
    |> System.String.Concat