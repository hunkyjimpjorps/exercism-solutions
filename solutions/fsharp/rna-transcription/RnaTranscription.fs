module RnaTranscription

let toRna (dna: string) : string =
    seq {
        for b in dna do
            yield
                match b with
                | 'G' -> 'C'
                | 'C' -> 'G'
                | 'T' -> 'A'
                | 'A' -> 'U'
                | _ -> failwith "Invalid base"
    }
    |> System.String.Concat
