is_divisible_by(Base, Number) :- 0 is Number mod Base.

get_multiples_up_to(UpperLimit, Base, Multiples) :-
    numlist(1, UpperLimit, NumberList),
    include(is_divisible_by(Base), NumberList, Multiples).    

sum_of_multiples(Factors, Limit, 0) :-
    min_list(Factors, MinFactor),
    Limit < MinFactor.
sum_of_multiples(Factors, Limit, Sum) :-
    UpperLimit is Limit - 1,
    maplist(get_multiples_up_to(UpperLimit), Factors, AllMultiples),
    append(AllMultiples, Multiples),
    list_to_set(Multiples,UniqueMultiples),
    sum_list(UniqueMultiples, Sum).