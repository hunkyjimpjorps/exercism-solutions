module TisburyTreasureHunt

let getCoordinate (line: string * string) : string = snd line

let convertCoordinate (coordinate: string) : int * char = (int coordinate[0..0], coordinate[1])

let compareRecords (azarasData: string * string) (ruisData: string * (int * char) * string) : bool =
    let (_, azarasCoordinate) = azarasData
    let (_, ruisCoordinate, _) = ruisData
    convertCoordinate azarasCoordinate = ruisCoordinate

let createRecord
    (azarasData: string * string)
    (ruisData: string * (int * char) * string)
    : (string * string * string * string) =
    match (azarasData, ruisData) with
    | ((item, azarasCoordinate), (location, _, color)) when compareRecords azarasData ruisData ->
        (azarasCoordinate, location, color, item)
    | _ -> ("", "", "", "")
