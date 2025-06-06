:- use_module(library(dcg/basics)).
char([X]) --> [X].

encode(Plaintext, Ciphertext) :-
    string_chars(Plaintext, Chars),
    once(collect_into_pairs(Chars, Pairs)),
    maplist(pair_to_string, Pairs, Substrs),
    atomics_to_string(Substrs, Ciphertext).

collect_into_pairs([], []) :- !.
collect_into_pairs(Chars, [Count-Head0|RestOfPairs]) :-
    Chars = [Head0 | _],
    append(Repeated, Next, Chars),
    maplist(=(Head0), Repeated),
    (   Next = [Head1| _] 
        ->  Head0 \= Head1 
        ;   true),
    length(Repeated, Count),
    collect_into_pairs(Next, RestOfPairs).

pair_to_string((1-V), Str) :- atom_string(V, Str), !.
pair_to_string((K-V), Str) :-
    format(string(Str), '~w~w', [K, V]).
    
decode(Ciphertext, Plaintext) :-
    string_chars(Ciphertext, Chars),
    once(break_into_pairs(Chars, Pairs)),
    maplist(expand_pair, Pairs, Substrs),
    atomics_to_string(Substrs, Plaintext).

break_into_pairs([], []).
break_into_pairs(Chars, [Count-Char|RestOfPairs]) :-
    (   phrase((integer(Count), char([Char])), Chars, Rest)
        -> break_into_pairs(Rest, RestOfPairs)
        ;   Chars = [Char | Rest],
            Count = 1,
            break_into_pairs(Rest, RestOfPairs)).

expand_pair((K-V), Str) :-
    length(Chars, K), maplist(=(V), Chars),
    atomics_to_string(Chars, Str).