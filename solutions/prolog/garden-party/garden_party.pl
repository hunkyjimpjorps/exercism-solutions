:- use_module(library(clpfd)).
:- use_module(library(yall)).
:- use_module(library(apply)).

name_pairs([aisha-1, emma-2, mei-3, winona-4]).

beverage(Chef, Beverage) :- 
    name_pairs(Names),
    BevNames = [tonic, lassi, kombucha, amasi],
    solution(Bevs, _),
    maplist([K, V, K-V]>>true, Bevs, BevNames, Pairs),
    once(member((Chef-N), Names)),
    once(member((N-Beverage), Pairs)).

dish(Chef, Dish) :- 
    name_pairs(Names),
    DishNames = [pad_thai, frybread, tagine, biryani],
    solution(_, Dishes),
    maplist([K, V, K-V]>>true, Dishes, DishNames, Pairs),
    once(member((Chef-N), Names)),
    once(member((N-Dish), Pairs)).

solution(BevVars, DishVars) :-
    name_pairs(Names), pairs_values(Names, NameVars),
    NameVars = [Aisha, Emma, Mei, Winona],
    BevVars = [Tonic, Lassi, _Kombucha, Amasi],
    DishVars = [PadThai, Frybread, Tagine, Biryani],
    maplist(all_distinct, [BevVars, DishVars]),
    BevVars ins 1..4, DishVars ins 1..4,

    Aisha #= Tagine,
    Emma #= Amasi,
    Frybread #= Tonic,
    Mei #= Lassi,
    Winona #\= PadThai,
    Amasi #\= Biryani,

    label(BevVars).


