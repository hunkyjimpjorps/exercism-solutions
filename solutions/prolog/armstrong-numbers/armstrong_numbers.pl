armstrong_number(N) :-
    number_chars(N, S), length(S, Len),
    foldl(char_to_power(Len), S, 0, N1),
    N1 =:= N.

char_to_power(Len, Char, Acc, Result) :-
    atom_number(Char, N),
    Result is Acc + N ** Len.
