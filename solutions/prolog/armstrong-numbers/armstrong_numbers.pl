armstrong_number(N) :-
    number_chars(N, S),
    length(S, Len),
    maplist(char_to_power(Len), S, Digits),
    foldl(plus, Digits, 0, N1),
    N1 =:= N.

char_to_power(Len, Char, Result) :-
    atom_number(Char, N),
    Result is N ** Len.
