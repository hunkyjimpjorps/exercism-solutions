% Please visit https://exercism.io/tracks/prolog/installation
% for instructions on setting up prolog.
% Visit https://exercism.io/tracks/prolog/tests
% for help running the tests for prolog exercises.

% Replace the goal below with
% your implementation.

create((Rank, File)) :-
    between(0, 7, Rank),
    between(0, 7, File).

attack((R, _), (R, _)).
attack((_, F), (_, F)).
attack((R1, F1), (R2, F2)) :-
    abs(-(R1, R2)) =:= abs(-(F1, F2)).