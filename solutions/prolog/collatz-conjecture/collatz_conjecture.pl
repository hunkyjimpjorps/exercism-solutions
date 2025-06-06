collatz_steps(1, 0) :- true.

collatz_steps(N, Steps) :-
    N > 0, 
    (   0 is N mod 2
    ->  PrevN is N / 2
    ;   PrevN is 3 * N + 1
    ),
    collatz_steps(PrevN, PrevSteps),
    Steps is PrevSteps + 1.