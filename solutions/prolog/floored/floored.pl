:- use_module(library(clpfd)).

floor(Name, Floor) :-
    solution(Pairs),
    once(member(Name-Floor, Pairs)).

solution(Pairs) :-
    Floors = [Amara, Bjorn, Cora, Dale, Emiko],
    Names = [amara, bjorn, cora, dale, emiko],
    Floors ins 1..5,
    all_distinct(Floors),
    Amara #\= 5, 
    Bjorn #\= 1,
    Cora #\= 1, Cora #\= 5,
    Dale #> Bjorn,
    not_adjacent(Emiko, Cora),
    not_adjacent(Cora, Bjorn),
    label(Floors),
    pairs_keys_values(Pairs, Names, Floors).

not_adjacent(A, B) :-
    abs(A - B) #\= 1.
    
