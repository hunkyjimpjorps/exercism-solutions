two_fer(Name, Dialogue) :-
    swritef(Dialogue, "One for %w, one for me.", [Name]).

two_fer(Dialogue) :-
    two_fer("you", Dialogue).
