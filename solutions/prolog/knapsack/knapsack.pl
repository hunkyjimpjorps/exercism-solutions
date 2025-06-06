:- use_module(library(clpfd)).
:- use_module(library(yall)).
:- use_module(library(apply)).

maximum_value([], _, 0) :- !.
maximum_value(Items, Capacity, Value) :-
    maplist([I, W, V]>>(I = item(W, V)), Items, Weights, Values),
    same_length(Items, Chosen),
    Chosen ins 0..1,
    maplist([C, W, V, CW, CV]>>(C * W #= CW, C * V #= CV), 
        Chosen, Weights, Values, ChosenWeights, ChosenValues),
    sum(ChosenWeights, #=<, Capacity),
    sum(ChosenValues, #=, Value),
    sum(Chosen, #>, 0),
    once(labeling([ff, max(Value)], Chosen)).
