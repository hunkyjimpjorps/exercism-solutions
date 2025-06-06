conversions([
    (1000-"M"),
    (900-"CM"),
    (500-"D"),
    (400-"CD"),
    (100-"C"),
    (90-"XC"),
    (50-"L"),
    (40-"XL"),
    (10-"X"),
    (9-"IX"),
    (5-"V"),
    (4-"IV"),
    (1-"I")
    ]).

convert(0, "").
convert(N, Roman) :-
    conversions(Conversions),
    member(NextVal-NextStr, Conversions),
    NextVal =< N,
    N1 is N - NextVal,
    convert(N1, RestOfStr),
    string_concat(NextStr, RestOfStr, Roman), !.