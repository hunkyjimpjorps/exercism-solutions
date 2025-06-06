module OcrNumbers
let splitIntoCharBlocks strs =
    strs 
    |> List.map (Seq.toList)
    |> List.map (List.chunkBySize 3)
    |> List.transpose
    |> List.map (List.concat)

let chars =
    [ 
    " _     _  _     _  _  _  _  _ ";
    "| |  | _| _||_||_ |_   ||_||_|";
    "|_|  ||_  _|  | _||_|  ||_| _|";
    "                              " 
    ] |> splitIntoCharBlocks

let charMap =
    seq {0 .. 9} 
    |> Seq.toList
    |> List.zip chars
    |> Map.ofList

let convertOne input = 
    match Map.tryFind input charMap with
    | Some n -> string n
    | None -> "?"

let convertLine input =
    input 
    |> splitIntoCharBlocks
    |> List.map convertOne
    |> String.concat ""

let convert input =
    if List.length input % 4 <> 0 || String.length input[0] % 3 <> 0 then
        None
    else
        input
        |> List.chunkBySize 4
        |> List.map convertLine
        |> String.concat ","
        |> Some