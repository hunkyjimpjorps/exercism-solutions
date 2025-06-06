base_pairs([ ('A', 'U'), ('T', 'A'), ('C', 'G'), ('G', 'C') ]).

transcribe(Dna, Rna) :- 
    base_pairs(Pairs), 
    member((Dna, Rna), Pairs), !.

rna_transcription(Dna, Rna) :-
    string_chars(Dna, DnaChars),
    maplist(transcribe, DnaChars, RnaChars),
    string_chars(Rna, RnaChars).