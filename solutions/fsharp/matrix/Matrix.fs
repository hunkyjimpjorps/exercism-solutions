module Matrix

open FSharpx 

let stringToMatrix (str: string) : int [,] =
    str
    |> String.splitChar [| '\n' |]
    |> Array.map (String.splitChar [| ' ' |] >> Array.map int)
    |> array2D

let row index matrix =
    stringToMatrix matrix
    |> fun m -> m.[index-1, *]
    |> Array.toList

let column index matrix =
    stringToMatrix matrix
    |> fun m -> m.[*, index-1]
    |> Array.toList
