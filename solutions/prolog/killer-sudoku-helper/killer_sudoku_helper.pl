:- use_module(library(clpfd)).

combinations(Size, Sum, Exclude, Results) :-
    length(Xs, Size),
    sum(Xs, #=, Sum),
    Xs ins 1..9,
    append(Xs, Exclude, AllNumbers),
    all_distinct(AllNumbers),
    ascending(Xs),
    findall(Xs, label(Xs), Results), !.

ascending([_]).
ascending([X1 | X]) :- X = [X2 | _], X1 #< X2, ascending(X).