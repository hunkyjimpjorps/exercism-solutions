module Triangle

let uniqueSides (triangle: float list) =
    triangle |> List.distinct |> List.length

let triangleInequality triangle =
    triangle 
    |> List.sort 
    |> function 
        | [a; b; c] when a + b > c -> true
        | _ -> false

let equilateral triangle =
    uniqueSides triangle = 1 && triangleInequality triangle

let isosceles triangle =
    uniqueSides triangle <= 2 && triangleInequality triangle

let scalene triangle =
    uniqueSides triangle = 3 && triangleInequality triangle
