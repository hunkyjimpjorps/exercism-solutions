:- use_module(library(dcg/basics)).

sentence(Result) --> beginning, " ", expression(Result), ending.
sentence(_) --> beginning, {throw(error(syntax_error, "I can't solve this."))}.
sentence(_) --> {throw(error(unknown_operation_error, "I don't answer those questions."))}.

beginning --> "What is". 
ending --> "?".

:- table expression/3.
expression(Result) --> expression(N), " plus ", integer(M), {Result is N + M}, !.
expression(Result) --> expression(N), " minus ", integer(M), {Result is N - M}, !.
expression(Result) --> expression(N), " multiplied by ", integer(M), {Result is N * M}, !.
expression(Result) --> expression(N), " divided by ", integer(M), {Result is N / M}, !.
expression(Result) --> integer(Result), !.
expression(_) --> 
    integer(_), " ", string(_), 
    {throw(error(unknown_operation_error, "I don't know that operation."))}.

wordy(Question, Result) :- 
    string_codes(Question, StringCodes),
    once(phrase(sentence(Result), StringCodes, [])).
