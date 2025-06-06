dna_bases(['A', 'C', 'G', 'T']).

valid_nucleotide(X) :- 
    dna_bases(B), member(X, B).

valid_nucleotide_list([H|T]) :- 
    valid_nucleotide(H), valid_nucleotide_list(T).
valid_nucleotide_list([]).

count_of(List, X, (X, Count)) :-
    include(=(X), List, ListFiltered),
    length(ListFiltered, Count).

nucleotide_count(BaseAtom, CountList) :- 
    atom_chars(BaseAtom, BaseList),
    valid_nucleotide_list(BaseList),
    dna_bases(B), maplist(count_of(BaseList), B, CountList).
    
