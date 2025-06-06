module ScaleGenerator

let noteNameSharps : string list =
    [ "C"; "C#"; "D"; "D#"; "E"; "F"; "F#"; "G"; "G#"; "A"; "A#"; "B" ]

let noteNameFlats : string list =
    [ "C"; "Db"; "D"; "Eb"; "E"; "F"; "Gb"; "G"; "Ab"; "A"; "Bb"; "B" ]

let chromatic (tonic: string) : string list =
    let noteList =
        match tonic with
        | "C" | "G"  | "D"  | "A"  | "E"  | "B"  | "F#"
        | "a" | "e"  | "b"  | "f#" | "c#" | "g#" | "d#" -> noteNameSharps
        | "F" | "Bb" | "Eb" | "Ab" | "Db" | "Gb"
        | "d" | "g"  | "c"  | "f"  | "bb" | "eb" -> noteNameFlats
        | _ -> failwith "Invalid tonic"

    let rec rearrange (topTonic: string) (notes: string list) : string list =
        match notes with
        | h :: _ when h.ToUpper() = topTonic.ToUpper() -> notes
        | h :: t -> rearrange topTonic (t @ [ h ])
        | [] -> failwith "Invalid note list"

    rearrange tonic noteList

let interval (intervals: string) (tonic: string) : string list =
    let noteList = chromatic tonic

    let rec buildScale (steps: char list) (notes: string list) (acc: string list) =
        match steps with
        | [] -> acc
        | h :: t ->
            match h with
            | 'm' -> 1
            | 'M' -> 2
            | 'A' -> 3
            | _ -> failwith "Invalid interval"
            |> fun interval ->
                if notes.[interval].ToUpper() = tonic.ToUpper() then
                    acc
                else
                    buildScale t (List.skip interval notes) (acc @ [ notes.[interval] ])

    (List.head noteList)
    :: (buildScale (Seq.toList intervals) (noteList @ [ tonic ]) [])
