leap(X) :- 
    0 is X mod 400;
    0 is X mod 4, not(0 is X mod 100).