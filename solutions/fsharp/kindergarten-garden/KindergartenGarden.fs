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
    | _ -> Nothing

let divideGardenPlots (plots: string) : string list =
    plots
    |> Strings.split '\n'
    |> Array.toList
    |> List.map (Seq.chunkBySize 2)
    |> List.map (Seq.toList)
    |> List.map (List.map System.String)
    |> (fun g -> List.map2 (fun a b -> a + b) g.[0] g.[1])

let matchGardenPlotSeeds (plots: string) : Plant list =
    let rec matchNext (plots: char list) : Plant list =
        match plots with
        | [] -> []
        | head :: [] -> getPlantType head :: []
        | head :: tail -> getPlantType head :: matchNext tail

    matchNext (Seq.toList plots)

let plants (diagram: string) (student: string) : Plant list =
    let gardenPlots = divideGardenPlots diagram
    matchGardenPlotSeeds gardenPlots.[List.findIndex (fun x -> x = student) studentList]
