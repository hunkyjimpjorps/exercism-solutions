unique_sides(Sides, N) :- 
    \+ member(0, Sides),
    sort(0, @=<, Sides, [Short1, Short2, Long]),
    Short1 + Short2 >= Long,
    list_to_set(Sides, UniqueSides),
    length(UniqueSides, N).

classify_triangle(1, "equilateral").
classify_triangle(1, "isosceles").
classify_triangle(2, "isosceles").
classify_triangle(3, "scalene").    

triangle(A, B, C, Type) :- 
    unique_sides([A, B, C], N),
    once(classify_triangle(N, Type)). 