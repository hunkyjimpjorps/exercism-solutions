module KindergartenGarden

open FSharpx.Text

type Plant =
    | Clover
    | Grass
    | Radishes
    | Violets
    | Nothing

let studentList =
    [ "Alice"
      "Bob"
      "Charlie"
      "David"
      "Eve"
      "Fred"
      "Ginny"
      "Harriet"
      "Ileana"
      "Joseph"
      "Kincaid"
      "Larry" ]

let getPlantType (plant: char) : Plant =
    match plant with
    | 'C' -> Clover
    | 'G' -> Grass
    | 'R' -> Radishes
    | 'V' -> Violets
    | _ -> failwith "Not a valid seed type"

let divideGardenPlots (plots: string) : string list =
    plots
    |> Strings.split '\n'
    |> Array.toList
    |> List.map (Seq.chunkBySize 2)
    |> List.map (Seq.toList)
    |> List.map (List.map System.String)
    |> (fun g -> List.map2 (fun a b -> a + b) g.[0] g.[1])

let plants (diagram: string) (student: string) : Plant list =
    let gardenPlots = divideGardenPlots diagram

    match List.tryFindIndex (fun x -> x = student) studentList with
    | Some s ->
        gardenPlots.[s]
        |> Seq.toList
        |> List.map getPlantType
    | None -> failwith "Not a student in this class"
