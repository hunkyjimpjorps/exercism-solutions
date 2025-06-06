:- use_module(library(clpfd)).
:- use_module(library(yall)).
:- use_module(library(apply)).

maximum_value([], _, 0) :- !.
maximum_value(Items, Capacity, Value) :-
    maplist([I, W, V]>>(I = item(W, V)), Items, Weights, Values),
    same_length(Items, Chosen),
    Chosen ins 0..1,
    sum(Chosen, #>, 0),
    scalar_product(Weights, Chosen, #=<, Capacity),
    scalar_product(Values, Chosen, #=, Value),
    once(labeling([max(Value)], Chosen)).
