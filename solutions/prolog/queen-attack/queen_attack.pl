create((Rank, File)) :-
    between(0, 7, Rank),
    between(0, 7, File).

attack(Piece1, Piece2) :- 
    create(Piece1), 
    create(Piece2), 
    do_attack(Piece1, Piece2).

do_attack((X, _), (X, _)) :- !.
do_attack((_, Y), (_, Y)) :- !.
do_attack((X1, Y1), (X2, Y2)) :-
    abs(X1 - X2) =:= abs(Y1 - Y2).