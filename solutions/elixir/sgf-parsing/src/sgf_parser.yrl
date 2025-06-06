Nonterminals
    root
    child_tree
    child_trees
    node
    nodes
    property
    properties
    property_value
    property_values
.

Terminals
    val
    oparen
    cparen
    obracket
    cbracket
    sep
.

Rootsymbol
    root
.

root -> '$empty' : return_error(1, no_tree).
root -> sep : return_error(1, no_tree).
root -> oparen cparen : return_error(1, no_nodes).
root -> oparen sep nodes cparen : '$3'.

nodes -> node sep nodes : #{children => ['$3'], properties => '$1'}.
nodes -> node child_trees : #{children => '$2', properties => '$1'}.
nodes -> node : #{children => [], properties => '$1'}.
nodes -> '$empty' : #{properties => #{}}.

node -> properties : maps:from_list('$1').

child_trees -> child_tree child_trees : ['$1' | '$2'].
child_trees -> child_tree : ['$1'].
child_tree -> oparen sep properties cparen : #{children => [], properties => maps:from_list('$3')}.

properties -> property properties : ['$1' | '$2'].
properties -> property : ['$1'].

property -> val property_values : {check('$1'), '$2'}.
property -> val : return_error(1, no_delim).

property_values -> property_value property_values : ['$1' | '$2'].
property_values -> property_value : ['$1'].
property_value -> obracket val cbracket : unescape(ex('$2')).


Erlang code.

ex({_T, _L, V}) -> list_to_binary(V).

check({_T, _L, V}) -> 
    UpperV = string:uppercase(V),
    if
        UpperV == V -> list_to_binary(V);
        true -> return_error(1, bad_key)
    end.

unescape(V) -> 
    binary:replace(
        binary:replace(
            binary:replace(V, <<"\\]">>, <<"]">>, [global]), 
            <<"\\n">>, <<"\n">>, [global]),
        <<"\\t">>, <<"\t">>, [global]).