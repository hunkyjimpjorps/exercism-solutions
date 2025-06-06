sort_letters(Word, OrderedLetters) :-
    unicode_map(Word, LowerCaseWord, [casefold]),    
    atom_chars(LowerCaseWord, Letters),
    sort(0, @=<, Letters, OrderedLetters).

compare_case_insensitive(Word1, Word2) :-
    unicode_map(Word1, Word1LC, [casefold]),
    unicode_map(Word2, Word2LC, [casefold]),
    Word1LC == Word2LC.

anagram_matches(BaseWord, CandidateWord) :-
    \+ compare_case_insensitive(BaseWord, CandidateWord),
    sort_letters(BaseWord, BaseOrderedLetters),
    sort_letters(CandidateWord, CandidateOrderedLetters),
    BaseOrderedLetters == CandidateOrderedLetters. 
    
anagram(Word, Options, Matching) :-
    include(anagram_matches(Word), Options, Matching).
