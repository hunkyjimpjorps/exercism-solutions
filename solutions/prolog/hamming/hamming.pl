list_difference([], [], 0).
list_difference([SameHead | Tail1], [SameHead | Tail2], Diff) :-
    list_difference(Tail1, Tail2, Diff).
list_difference([_ | Tail1], [_ | Tail2], Diff) :-
    list_difference(Tail1, Tail2, DiffMinusOne), Diff is DiffMinusOne + 1.

hamming_distance(Str1, Str2, Result) :- 
    string_length(Str1, L), string_length(Str2, L),
    string_chars(Str1, Lst1), string_chars(Str2, Lst2),
    list_difference(Lst1, Lst2, Result).
