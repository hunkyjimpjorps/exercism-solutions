Definitions.

Rules.
\( : {token, {oparen, TokenLine}}.
\) : {token, {cparen, TokenLine}}.
\[ : {token, {obracket, TokenLine}}.
\] : {token, {cbracket, TokenLine}}.
\; : {token, {sep, TokenLine}}.

(\\.|[A-Za-z0-9\s])+ : {token, {val, TokenLine, TokenChars}}.

Erlang code.

