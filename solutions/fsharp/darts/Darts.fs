module Darts

let (|RadiusGreaterThan|) r (x, y) : bool = sqrt (x ** 2.0 + y ** 2.0) > r

let score (x: double) (y: double) : int =
    match x, y with
    | RadiusGreaterThan 10.0 true -> 0
    | RadiusGreaterThan 5.0 true -> 1
    | RadiusGreaterThan 1.0 true -> 5
    | _ -> 10
