leap(X) :- 
    0 is mod(X,400);
    0 is mod(X,4), not(0 is mod(X,100)).