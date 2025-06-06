create((Rank, File)) :-
    between(0, 7, Rank),
    between(0, 7, File).

attack((R, _), (R, _)).
attack((_, F), (_, F)).
attack((R1, F1), (R2, F2)) :-
    abs(-(R1, R2)) =:= abs(-(F1, F2)).