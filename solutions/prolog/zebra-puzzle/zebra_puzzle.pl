:- use_module(library(clpfd)).

zebra_owner(Owner) :- solution(_, _, Owner), !.

water_drinker(Drinker) :- solution(_, Drinker, _), !.

solution(Pairs, WaterDrinker, ZebraOwner) :-
    Relations = [Houses, Nations, Drinks, Smokes, Pet],
    Houses = [Blue, Green, Ivory, Red, Yellow],
    Nations = [England, Japan, Norway, Spain, Ukraine],
    Drinks = [Coffee, Milk, OrangeJuice, Tea, Water],
    Smokes = [Ches, Kool, Luck, Parl, OldG],
    Pet = [Dog, Fox, Horse, Snail, Zebra],
    Names = [english, japanese, norwegian, spanish, ukrainian],

    maplist(all_distinct, Relations),
    append(Relations, Locations),

    Locations ins 1..5,

    England #= Red,
    Spain #= Dog,
    Coffee #= Green,
    Ukraine #= Tea,
    Green #= Ivory + 1,
    OldG #= Snail,
    Kool #= Yellow,
    Milk #= 3,
    Norway #= 1,
    abs(Ches - Fox) #= 1,
    abs(Kool - Horse) #= 1,
    Luck #= OrangeJuice,
    Japan #= Parl,
    abs(Norway - Blue) #= 1,

    label(Locations),

    pairs_keys_values(Pairs, Nations, Names),
    member(Zebra-ZebraOwner, Pairs),
    member(Water-WaterDrinker, Pairs).