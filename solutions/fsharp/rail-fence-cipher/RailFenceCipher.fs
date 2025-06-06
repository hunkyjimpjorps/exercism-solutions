module RailFenceCipher

let template rails =
    // the row pattern goes 0, 1, ... n-1, n, n-1, ... 1, 0, 1 ...
    seq {
        while true do
            yield! [| 0 .. rails - 1 |]
            yield! [| rails - 2 .. -1 .. 1 |]
    }

let encode (rails: int) (message: string) =
    // attach row numbers in the template to characters
    Seq.zip (template rails) message
    // sort by the row numbers
    |> Seq.sortBy fst
    // drop the row numbers and assemble the string
    |> Seq.map snd
    |> System.String.Concat

let decode rails (message: string) =
    // attach row numbers to each place in the template
    Seq.zip (template rails) [| 1 .. message.Length |]
    // sort by the row numbers, so that all the row 0 positions are first
    // then the row 1 positions, etc.
    |> Seq.sortBy fst
    // attach the characters to the template positions
    |> Seq.zip message
    // sort by the template positions
    |> Seq.sortBy (snd >> snd)
    // retrieve the characters and assemble the string
    |> Seq.map fst 
    |> System.String.Concat