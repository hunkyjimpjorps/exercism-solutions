char_to_digit('1', 1).
char_to_digit('0', 0).

place_value(Digit, Index, Value) :-
    Value is Digit * 2 ** Index.

binary(Str, Dec) :-
    atom_chars(Str, DigitChars),
    maplist(char_to_digit, DigitChars, DigitsHighToLow),
    reverse(DigitsHighToLow, Digits),
    length(Digits, N), DigitsLength is N-1, 
    numlist(0, DigitsLength, Indices),
    maplist(place_value, Digits, Indices, Values),
    sum_list(Values, Dec).
    