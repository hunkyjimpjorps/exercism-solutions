students([alice, bob, charlie, david, eve, fred, ginny, harriet, ileana, joseph, kincaid, larry]).

plants('C', clover).
plants('G', grass).
plants('R', radishes).
plants('V', violets).

garden(Garden, Child, Plants) :-
    students(Students),
    once(nth1(Number, Students, Child)), 
    split_string(Garden, "\n", "", RowStrings),
    maplist(string_chars, RowStrings, Rows),
    transform_rows_to_beds(Rows, Beds),
    nth1(Number, Beds, Bed),
    maplist(plants, Bed, Plants).

transform_rows_to_beds([[], []], []).
transform_rows_to_beds([[R1_1, R1_2 | Rest1], [R2_1, R2_2 | Rest2]], Beds) :-
    transform_rows_to_beds([Rest1, Rest2], RestOfBeds),
    Beds = [[R1_1, R1_2, R2_1, R2_2] | RestOfBeds].
    