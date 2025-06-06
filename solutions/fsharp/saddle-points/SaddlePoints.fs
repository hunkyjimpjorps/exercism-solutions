module SaddlePoints

let saddlePoints (mat: int list list) : (int * int) list =

    let m =
        Array2D.initBased 1 1 mat.Length mat.[0].Length (fun i j -> (mat.[i - 1].[j - 1], (i, j)))

    Seq.cast m
    |> Seq.choose
        (fun (n, ((i, j) as t)) ->
            if n = Array.max (Array2D.map fst m).[i, *]
               && n = Array.min (Array2D.map fst m).[*, j] then
                Some t
            else
                None)
    |> Seq.toList
