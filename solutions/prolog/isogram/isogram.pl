is_lowercase(Char) :-
    char_type(Char, lower).

isogram(Word) :- 
    downcase_atom(Word, LowerCaseWord),
    string_chars(LowerCaseWord, CharList),
    include(is_lowercase, CharList, CleanedCharList),      
    list_to_set(CleanedCharList, UniqueChars),
    same_length(CleanedCharList, UniqueChars).   
    