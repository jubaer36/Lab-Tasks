edge(a, b).
edge(b, c).
edge(c, d).
edge(d, e).
edge(c, e).

% Direct edge
find_path(Start, End, [Start, End]) :-
    edge(Start, End).

% Recursive path
find_path(Start, End, [Start|Path]) :-
    edge(Start, X),
    find_path(X, End, Path).


find_path(a, c, X).
find_path(e, a, X).

