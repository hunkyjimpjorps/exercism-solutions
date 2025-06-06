module SaddlePoints

let saddlePoints (matrix: int list list) =

    let m =
        Array2D.initBased 1 1 matrix.Length matrix.[0].Length (fun i j -> matrix.[i - 1].[j - 1])

    m
    |> Array2D.mapi (fun i j n -> (n, (i, j)))
    |> Seq.cast
    |> Seq.filter (fun (n, (i, j)) -> n = Array.max m.[i, *] && n = Array.min m.[*, j])
    |> Seq.map snd
    |> Seq.toList
