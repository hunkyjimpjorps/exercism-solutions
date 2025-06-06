module SaddlePoints

let saddlePoints (mat: int list list) : (int * int) list =

    let m =
        Array2D.initBased 1 1 mat.Length mat.[0].Length (fun i j -> mat.[i - 1].[j - 1])

    Array2D.mapi (fun i j n -> (n, (i, j))) m
    |> Seq.cast
    |> Seq.filter (fun (n, (i, j)) -> n = Array.max m.[i, *] && n = Array.min m.[*, j])
    |> Seq.map snd
    |> Seq.toList
