% Base case
flatten_list([], []).

% If head is a list
flatten_list([H|T], Flat) :-
    flatten_list(H, FH),
    flatten_list(T, FT),
    append(FH, FT, Flat).

% If head is not a list
flatten_list(X, [X]) :-
    X \= [],
    \+ is_list(X).

flatten_list([[a,b],[c],[b,d,e]], X).
