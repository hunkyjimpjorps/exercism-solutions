flatten_list([], []) :- !.

flatten_list([nil | Tail], Result) :-
    flatten_list(Tail, Result), !.

flatten_list([Head | Tail], Result) :-
    is_list(Head),
    flatten_list(Head, FlattenedHead),
    flatten_list(Tail, FlattenedTail),
    append(FlattenedHead, FlattenedTail, Result), !.

flatten_list([Head | Tail], [Head | FlattenedTail]) :-
    flatten_list(Tail, FlattenedTail), !.