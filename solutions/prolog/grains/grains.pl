square(1, 1):- true, !.
square(N, Grains) :- 
    between(1, 64, N),
    Previous is N - 1,
    square(Previous, PreviousGrains),
    Grains is PreviousGrains * 2.

total(Value) :-
    numlist(1, 64, Squares),
    maplist(square, Squares, Grains),
    sum_list(Grains, Value). 