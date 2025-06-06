pascal(0, []):- true, !.
pascal(1, [[1]]):- true, !.

pascal(N, List) :-
    PreviousN is N - 1,
    pascal(PreviousN, PreviousList),
    last(PreviousList, Previous),
    append([0], Previous, LeftSide),
    append(Previous, [0], RightSide),
    maplist(plus, LeftSide, RightSide, NewRow),
    append(PreviousList, [NewRow], List).
    