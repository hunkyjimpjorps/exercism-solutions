string_reverse(S, Reversed) :-
    string_chars(S, Chars),
    reverse(Chars, R),
    string_chars(Reversed, R).